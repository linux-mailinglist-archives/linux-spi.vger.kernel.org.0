Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DCB77A059D
	for <lists+linux-spi@lfdr.de>; Thu, 14 Sep 2023 15:32:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbjINNdB (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 14 Sep 2023 09:33:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbjINNdA (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 14 Sep 2023 09:33:00 -0400
Received: from mail.3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BAE91BF8;
        Thu, 14 Sep 2023 06:32:56 -0700 (PDT)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id E58C4F84;
        Thu, 14 Sep 2023 15:32:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1694698375;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RF2qkedgoAlrSVTvXCvJ0qPTwTx2s0DX5GrzCTtx8WI=;
        b=zgAxl6P2QDz7zGS3O3jkVwPwIzzSXp66sxgcS+3uylYavsl37ODExKGZzprRQt8cIctr6+
        awTY8lp76lc0UZTeFsUhYySJFCmS3Ow7bM0xzEFX53OR86olfCFOXycgAp7J8NF8J+MxU8
        1UqyJHq47hrjprk5nlruhRlMe2v8eSaXd6mzK/SSxd6flS8D/Y1fINJdHr1IIDrVPviaZ+
        2kkULEYQszv6rWONcnZYHROwOsRj3+I0x0lOJPiVpi3M/WC77C9mLiz11L2yjmcO/aICVK
        KpLzDsiRbEaA9HrC+fEsPC6DHPG+UWUSnZnX+KML7eu/t7nGkPse9+0BkY8Jsw==
MIME-Version: 1.0
Date:   Thu, 14 Sep 2023 15:32:54 +0200
From:   Michael Walle <michael@walle.cc>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
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
In-Reply-To: <9bf6cf6f104145080d38c8658000c24b@walle.cc>
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
 <737c6865703b8e294601d86a911691da@walle.cc>
 <OS0PR01MB5922A4F16DE8923373AA5DD886F7A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <41a960b2a039ab88cb8a6ed6ed21e067@walle.cc>
 <OS0PR01MB5922AED5B1490E251669F45186F7A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <9bf6cf6f104145080d38c8658000c24b@walle.cc>
Message-ID: <030c666c5284bcbd20f6d09caa8f077f@walle.cc>
X-Sender: michael@walle.cc
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


>> For eg: here Adesto flash requires HI-Z for IO3 pin and Micron flash
>> requires setting "1" for IO3 pin for 4-bit mode to work.
> 
> That is odd. You'd need to ask Micron, but I assume it is because
> IO3 is shared with hold# and reset#. And there is a note "For pin
> configurations that share the DQ3 pin with RESET#, the RESET#
> functionality is disabled in QIO-SPI mode". So I guess the reason
> why they asking for a '1' is because they don't want to reset the
> flash. I'm pretty sure, we don't really support this in linux, so
> you'd probably want to disable that feature, i.e. see Table 7,
> bit 4. You could also come around this by enabling a pull-up on
> that line (assuming the SPI controller 'drives' HiZ during command
> phase).

Oh and I forgot. You probably can do some kind of fixup (where you
set this bit) for this flash in drivers/mtd/spi-nor/micron.c.

-michael
