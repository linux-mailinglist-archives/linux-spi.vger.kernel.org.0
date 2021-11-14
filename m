Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC65B44F9F9
	for <lists+linux-spi@lfdr.de>; Sun, 14 Nov 2021 19:41:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233136AbhKNSn6 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 14 Nov 2021 13:43:58 -0500
Received: from whuk3.redbackinternet.net ([109.203.107.222]:48498 "EHLO
        whuk3.redbackinternet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231128AbhKNSn6 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 14 Nov 2021 13:43:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=fbautosys.co.uk; s=default; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:To:Subject:From:Sender:Reply-To:Cc:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=SE+OdJV4PaIz2lgQxwhnFZH12rhB/D21Md0n9g2DRQg=; b=sRLzpkH0sxMBYFK8XpG7ELPQKG
        7xzGOFKioInS+1EdM1mlEE8W7fDEcoIJjubSzt9fWryjk9lrxox4/x3ULGhmRFCGaovRrysHyqjLC
        xBeyTop2wZalquqTpsnglXU8JGveNijiwn8zsg9j1SBYYaFmKqoUTuWPtlp+rsXrouM7rZdBEcQqy
        fkym2p6M78rZiD+5qpmYubLHbixJBvZB0yU/lBmicEab7pOsmls4cAjiuNj09HMV9E9vReEEfQbK9
        ArjsWp0yJWCYDss98M8BpwzxSyZoZ4OL0UrzO5VX6e0dvQMyNQzr+lKeE6DWLIzNSd8m7j9fDjK4T
        0YiJauPA==;
Received: from 24.54.187.81.in-addr.arpa ([81.187.54.24]:56689 helo=[192.168.1.37])
        by whuk3.redbackinternet.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <linuxkernel@fbautosys.co.uk>)
        id 1mmKR3-00042W-B1
        for linux-spi@vger.kernel.org; Sun, 14 Nov 2021 18:41:02 +0000
From:   christopher tyerman <linuxkernel@fbautosys.co.uk>
Subject: Remap, SPI and parity bit
To:     linux-spi@vger.kernel.org
Message-ID: <d9ef0f42-4ebe-b7db-f18f-8652dcf38ca0@fbautosys.co.uk>
Date:   Sun, 14 Nov 2021 18:41:00 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - whuk3.redbackinternet.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - fbautosys.co.uk
X-Get-Message-Sender-Via: whuk3.redbackinternet.net: authenticated_id: linuxkernel@fbautosys.co.uk
X-Authenticated-Sender: whuk3.redbackinternet.net: linuxkernel@fbautosys.co.uk
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

hello

I'm not sure if this is the correct place to be asking this, if there is 
a better place please redirect me.

I'm currently working on a kernel driver for the Texas Instruments 
tps92518-Q1 and tps92518HV-Q1.

This device uses 16-bit SPI Frames (7-bit control, 9-bit data).

is "Command Frame"

|1-bit command bit 5-bit Address 1-bit parity 9-bit data|

requires a parity bit

|PARITY = XNOR(CMD, A4..A0, D8..D0)|

I'm trying to use regmaps where possible and I can define a regmap, e.g.

|static struct regmap_config tps92518_regmap_config = { .reg_bits = 6, 
.pad_bits = 1, // parity bit .val_bits = 9, .max_register = 
tps92518_RESET, }; |

however so far i cannot currently see how to automatically calculate it 
without replacing large chunks of code

e.g replacing chunks of /drivers/base/regmap/regmap-spi.c with a new 
regmap_bus

some where i need to be able to calculate and insert a parity bit

is there anywhere i can setup a callback that preprocesses the spi 
frames before sending?


I'm working up the chain an i can see a potential patch to regmaps that 
would  fix this if nothing better already exists

with regmap_config exists /@read_flag_mask/ and /@write_flag_mask/, 
along the same line there could be added a "@read_parity_mask" and 
"@write_parity_mask"
and an optional "@reg_parity" callback that calculates the parity 
from/reg/ and /val/ similar/@reg_read/ and /@reg_write/ but without 
replacing the entire read/write operations

I may even be able to write this but that is outside the spi-subsystem, 
and i'm currently not sure what list regmaps fall under



i apologise if this is the wrong list and, thankyou for any responses

kind regards

christopher tyerman






