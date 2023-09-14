Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09DA97A0290
	for <lists+linux-spi@lfdr.de>; Thu, 14 Sep 2023 13:28:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238106AbjINL11 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 14 Sep 2023 07:27:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237892AbjINL1X (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 14 Sep 2023 07:27:23 -0400
Received: from mail.3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89D891FC4;
        Thu, 14 Sep 2023 04:27:18 -0700 (PDT)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id 5ADBCA06;
        Thu, 14 Sep 2023 13:27:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1694690833;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UwUtK0YqmeM4OoxgSY/5NQIv3Bs9GND70zEJZLkjSUY=;
        b=aw/UHpm63t01H3Lctv9vKQJvRaY1dqg1TEt9fscY6tXnMX5z7kCpR6M2ixPKJFltb78f5j
        Dyjmbxu50gopGOxKXbomX1jyz4gA0TlQcla7j4zNDstWeNr1LxDrq54Q0Xxd7ZXo+EjUEO
        zGxDfKSXoBi4CCKiO39C8QfY2lg3DRyVk/Hcg1CXLNjL6wPabTZNbFK6dGMK9Yxi/M5kIy
        uuEVoGjctCo5Tc2CFy3olgza17TglfDuLbXdbR0PsvGs9E7GhOOnXbrVmoAQOAjjJMEpJx
        RRDqnuF+jad5cnCxU8XDV8JtBCEA0DxwLyM2Ldv6p44W6BjpIaJv4aJTmwjpVA==
MIME-Version: 1.0
Date:   Thu, 14 Sep 2023 13:27:13 +0200
From:   Michael Walle <michael@walle.cc>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <tudor.ambarus@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        MTD Maling List <linux-mtd@lists.infradead.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH] memory: renesas-rpc-if: Fix IO state based on flash type
In-Reply-To: <CAMuHMdUA23VxkK-8CebyqiF=Oe81QZgpEmWmMrMGVd_+BXfsLA@mail.gmail.com>
References: <20230830145835.296690-1-biju.das.jz@bp.renesas.com>
 <CAMuHMdV1qvypo1XmHBXV5Q1SHEhksMN3SxgweYxPu+=ZeDmg1A@mail.gmail.com>
 <TYCPR01MB5933571F06789BFF27A8FCC786E6A@TYCPR01MB5933.jpnprd01.prod.outlook.com>
 <502336e9-2455-f3f6-57d1-807bc4b71f7f@linaro.org>
 <CAMuHMdWO8EdbxXetmc9-2jhZWeX1b_J74O0exo1Q85X9Gbc_SA@mail.gmail.com>
 <20230914105937.4af00bf2@xps-13>
 <CAMuHMdX8Vg2M2K3U_sbAtVk+6VDvL+GNYtbs5FTTRZzRvVGPCQ@mail.gmail.com>
 <20230914111200.6e6832ca@xps-13>
 <CAMuHMdVryt5bTk8HeFMS3NU-4EpQdU3Tf6LiGmGQQ5bVD-Emsg@mail.gmail.com>
 <OS0PR01MB5922B4BF11D1954DFBE2976F86F7A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <CAMuHMdUA23VxkK-8CebyqiF=Oe81QZgpEmWmMrMGVd_+BXfsLA@mail.gmail.com>
Message-ID: <737c6865703b8e294601d86a911691da@walle.cc>
X-Sender: michael@walle.cc
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi,

>> > I'm not sure we can do that, as this code is part of the hardware
>> > initialization during probing.
>> > Biju: is this needed that early, or can it be done later, after the
>> > connected device has been identified?
>> 
>> I need to check that.
>> 
>> You mean patch drivers/spi/spi-rpc-if.c
>> to identify the flash type from sfdp info and pass as a parameter to 
>> rpcif_hw_init??
> 
> Something like that.
> 
> That configuration should be saved somewhere, as rpcif_hw_init() is
> also called from rpcif_resume(), and when recovering from an error
> in rpcif_manual_xfer().

I'm not sure I follow everything here, but apparently you want to
set the mode of the I/O pins of the controller, right? Shouldn't
that depend on the spi-mem mode, i.e. the buswidth? Certainly
not on the type of flash which is connected to the spi controller.
What about dual mode?

-michael
