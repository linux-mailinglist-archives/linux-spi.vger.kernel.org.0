Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D728A5A7E71
	for <lists+linux-spi@lfdr.de>; Wed, 31 Aug 2022 15:15:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231756AbiHaNPs (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 31 Aug 2022 09:15:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231715AbiHaNPr (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 31 Aug 2022 09:15:47 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C2DF9AFBC;
        Wed, 31 Aug 2022 06:15:41 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MHl6L1w6Lz4xGS;
        Wed, 31 Aug 2022 23:15:38 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-spi@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
In-Reply-To: <20220824082130.21934-1-wsa+renesas@sang-engineering.com>
References: <20220824082130.21934-1-wsa+renesas@sang-engineering.com>
Subject: Re: [PATCH 0/2] spi: remove "spidev" nodes from DTs
Message-Id: <166195164122.45984.7055398708417257507.b4-ty@ellerman.id.au>
Date:   Wed, 31 Aug 2022 23:14:01 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, 24 Aug 2022 10:21:27 +0200, Wolfram Sang wrote:
> There were two DTs left specifying "spidev" directly. Remove them.
> 
> Wolfram Sang (2):
>   ARM: dts: stm32: argon: remove spidev node
>   powerpc/82xx: remove spidev node from mgcoge
> 
> arch/arm/boot/dts/stm32mp157c-emstamp-argon.dtsi | 6 ------
>  arch/powerpc/boot/dts/mgcoge.dts                 | 7 -------
>  2 files changed, 13 deletions(-)
> 
> [...]

Patch 2 applied to powerpc/next.

[2/2] powerpc/82xx: remove spidev node from mgcoge
      https://git.kernel.org/powerpc/c/fd20b60aea6a37788f2f761af405b41c6c34473b

cheers
