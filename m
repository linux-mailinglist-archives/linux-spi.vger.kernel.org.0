Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA4B36C62C4
	for <lists+linux-spi@lfdr.de>; Thu, 23 Mar 2023 10:07:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231225AbjCWJHG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-spi@lfdr.de>); Thu, 23 Mar 2023 05:07:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231634AbjCWJGl (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 23 Mar 2023 05:06:41 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0D9735EDD
        for <linux-spi@vger.kernel.org>; Thu, 23 Mar 2023 02:05:55 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1pfGsR-0000Sg-9T; Thu, 23 Mar 2023 10:04:55 +0100
Received: from [2a0a:edc0:0:900:1d::4e] (helo=lupine)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1pfGsM-0066qa-Rq; Thu, 23 Mar 2023 10:04:50 +0100
Received: from pza by lupine with local (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1pfGsG-0001jK-IS; Thu, 23 Mar 2023 10:04:44 +0100
Message-ID: <b5bf6c34b57fcfe1f6107e4c36e6198a78aaea79.camel@pengutronix.de>
Subject: Re: [PATCH v12 14/15] mmc: sdhci-cadence: Support mmc hardware reset
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Brad Larson <blarson@amd.com>, linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-spi@vger.kernel.org, adrian.hunter@intel.com,
        alcooperx@gmail.com, andy.shevchenko@gmail.com, arnd@arndb.de,
        brendan.higgins@linux.dev, briannorris@chromium.org,
        brijeshkumar.singh@amd.com, catalin.marinas@arm.com,
        davidgow@google.com, gsomlo@gmail.com, gerg@linux-m68k.org,
        krzk@kernel.org, krzysztof.kozlowski+dt@linaro.org, lee@kernel.org,
        lee.jones@linaro.org, broonie@kernel.org,
        yamada.masahiro@socionext.com, piotrs@cadence.com, p.yadav@ti.com,
        rdunlap@infradead.org, robh+dt@kernel.org, samuel@sholland.org,
        fancer.lancer@gmail.com, skhan@linuxfoundation.org,
        suravee.suthikulpanit@amd.com, thomas.lendacky@amd.com,
        tonyhuang.sunplus@gmail.com, ulf.hansson@linaro.org,
        vaishnav.a@ti.com, will@kernel.org, devicetree@vger.kernel.org
Date:   Thu, 23 Mar 2023 10:04:44 +0100
In-Reply-To: <20230323000657.28664-15-blarson@amd.com>
References: <20230323000657.28664-1-blarson@amd.com>
         <20230323000657.28664-15-blarson@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.38.3-1+deb11u1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mi, 2023-03-22 at 17:06 -0700, Brad Larson wrote:
> Add support for mmc hardware reset using a reset-controller
> that would need to be enabled in the device tree with
> a supporting driver.  The default is disabled for all
> existing designs.
> 
> Signed-off-by: Brad Larson <blarson@amd.com>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>


regards
Philipp
