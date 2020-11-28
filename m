Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44EAB2C71CC
	for <lists+linux-spi@lfdr.de>; Sat, 28 Nov 2020 23:04:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387636AbgK1Vuu (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 28 Nov 2020 16:50:50 -0500
Received: from mxout03.lancloud.ru ([89.108.73.187]:34594 "EHLO
        mxout03.lancloud.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387684AbgK1UV4 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 28 Nov 2020 15:21:56 -0500
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout03.lancloud.ru 51F72206646C
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
From:   Sergey Shtylyov <s.shtylyov@omprussia.ru>
Subject: Re: [PATCH for-5.10] spi: rpc-if: Fix use-after-free on unbind
To:     Lukas Wunner <lukas@wunner.de>, Mark Brown <broonie@kernel.org>
CC:     <linux-spi@vger.kernel.org>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
References: <73adc6ba84a4f968f2e1499a776e5c928fbdde56.1605512876.git.lukas@wunner.de>
 <bf610a9fc88376e2cdf661c4ad0bb275ee5f4f20.1605512876.git.lukas@wunner.de>
Organization: Open Mobile Platform, LLC
Message-ID: <9534f4fb-6f5e-b538-6903-e702a7301b1d@omprussia.ru>
Date:   Sat, 28 Nov 2020 23:20:50 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <bf610a9fc88376e2cdf661c4ad0bb275ee5f4f20.1605512876.git.lukas@wunner.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [213.87.136.201]
X-ClientProxiedBy: LFEXT01.lancloud.ru (fd00:f066::141) To
 LFEX1908.lancloud.ru (fd00:f066::208)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello!

On 11/16/20 11:23 AM, Lukas Wunner wrote:

> rpcif_spi_remove() accesses the driver's private data after calling
> spi_unregister_controller() even though that function releases the last
> reference on the spi_controller and thereby frees the private data.

   OK, your analysis seems correct (sorry for the delay admitting this :-).
   Not sure why spi_unregister_controller() drops the device reference while
spi_register_controller() itself doesn't allocate the memory... 

> Fix by switching over to the new devm_spi_alloc_master() helper which
> keeps the private data accessible until the driver has unbound.

   Perhaps the order of the calls in the remove() method could be reversed? 

> Fixes: eb8d6d464a27 ("spi: add Renesas RPC-IF driver")
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Cc: <stable@vger.kernel.org> # v5.9+: 5e844cc37a5c: spi: Introduce device-managed SPI controller allocation
> Cc: <stable@vger.kernel.org> # v5.9+
> Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
[...]

MBR, Sergei
