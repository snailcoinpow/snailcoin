// Copyright (c) 2023 The Bitcoin Core developers
// Copyright (c) 2024 The Snailcoin developers
// Copyright (c) 2025 The Satoshi Cash-X developers
// Distributed under the MIT software license, see the accompanying
// file COPYING or http://www.opensource.org/licenses/mit-license.php.

#include <util/chaintype.h>

#include <cassert>
#include <optional>
#include <string>

std::string ChainTypeToString(ChainType chain)
{
    switch (chain) {
    case ChainType::MAIN:
        return "main";
    case ChainType::TESTNET:
        return "test";
    case ChainType::TESTNET4:
        return "testnet4";
    case ChainType::SIGNET:
        return "signet";
    case ChainType::REGTEST:
        return "regtest";
    case ChainType::SNAILCOINMAIN:
        return "scashx";
    case ChainType::SNAILCOINTESTNET:
        return "scashxtestnet";
    case ChainType::SNAILCOINREGTEST:
        return "scashxregtest";
    }
    assert(false);
}

std::optional<ChainType> ChainTypeFromString(std::string_view chain)
{
    if (chain == "main") {
        return ChainType::MAIN;
    } else if (chain == "test") {
        return ChainType::TESTNET;
    } else if (chain == "testnet4") {
        return ChainType::TESTNET4;
    } else if (chain == "signet") {
        return ChainType::SIGNET;
    } else if (chain == "regtest") {
        return ChainType::REGTEST;
    } else if (chain == "scashx") {
        return ChainType::SNAILCOINMAIN;
    } else if (chain == "scashxtestnet") {
        return ChainType::SNAILCOINTESTNET;
    } else if (chain == "scashxregtest") {
        return ChainType::SNAILCOINREGTEST;
    } else {
        return std::nullopt;
    }
}
