Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAC84496BD3
	for <lists+linux-spi@lfdr.de>; Sat, 22 Jan 2022 12:08:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232530AbiAVLIK (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 22 Jan 2022 06:08:10 -0500
Received: from 4.mo582.mail-out.ovh.net ([87.98.184.159]:54769 "EHLO
        4.mo582.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233949AbiAVLIK (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 22 Jan 2022 06:08:10 -0500
Received: from player789.ha.ovh.net (unknown [10.109.138.76])
        by mo582.mail-out.ovh.net (Postfix) with ESMTP id 5578520D76
        for <linux-spi@vger.kernel.org>; Sat, 22 Jan 2022 10:28:27 +0000 (UTC)
Received: from etezian.org (82-181-27-157.bb.dnainternet.fi [82.181.27.157])
        (Authenticated sender: andi@etezian.org)
        by player789.ha.ovh.net (Postfix) with ESMTPSA id DEB73269A5523;
        Sat, 22 Jan 2022 10:28:11 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass (GARM-102R004083ec7c4-2316-4ca6-8030-7f2f6f6c0c61,
                    47613193A4C2821AFA139AF0D7345AE9E747044F) smtp.auth=andi@etezian.org
X-OVh-ClientIp: 82.181.27.157
Date:   Sat, 22 Jan 2022 12:28:10 +0200
From:   Andi Shyti <andi@etezian.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Alim Akhtar <alim.akhtar@samsung.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linus.walleij@linaro.org,
        robh+dt@kernel.org, linux-samsung-soc@vger.kernel.org,
        pankaj.dubey@samsung.com, broonie@kernel.org, andi@etezian.org,
        linux-spi@vger.kernel.org, linux-fsd@tesla.com,
        Adithya K V <adithya.kv@samsung.com>
Subject: Re: [PATCH v2 1/3] spi: dt-bindings: samsung: Add fsd spi compatible
Message-ID: <YevcOlARxNcBeDJE@jack.zhora.eu>
References: <20220120192438.25555-1-alim.akhtar@samsung.com>
 <CGME20220120193613epcas5p238851849d212e01d7d830d78ca7d6379@epcas5p2.samsung.com>
 <20220120192438.25555-2-alim.akhtar@samsung.com>
 <aa172f14-2328-fc7c-0063-5c0033970d1d@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa172f14-2328-fc7c-0063-5c0033970d1d@canonical.com>
X-Ovh-Tracer-Id: 15873781313358400152
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvvddrvddvgddujecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkfhggtggujgesthdtrodttddtvdenucfhrhhomheptehnughiucfuhhihthhiuceorghnughisegvthgviihirghnrdhorhhgqeenucggtffrrghtthgvrhhnpeevkeejgedvvdehveeuledtvdfgvdfggfehveekffffveekkeehkeegheeileefleenucfkpheptddrtddrtddrtddpkedvrddukedurddvjedrudehjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphhouhhtpdhhvghlohepphhlrgihvghrjeekledrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegrnhguihesvghtvgiiihgrnhdrohhrghdpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdhsphhisehvghgvrhdrkhgvrhhnvghlrdhorhhg
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Krzysztof and Alim,

On Fri, Jan 21, 2022 at 07:33:15PM +0100, Krzysztof Kozlowski wrote:
> On 20/01/2022 20:24, Alim Akhtar wrote:
> > Adds spi controller dt-binding compatible information for
> > Tesla Full Self-Driving (FSD) SoC.
> > 
> > Cc: linux-fsd@tesla.com
> > Signed-off-by: Adithya K V <adithya.kv@samsung.com>
> > Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
> > ---
> >  Documentation/devicetree/bindings/spi/samsung,spi.yaml | 1 +
> >  1 file changed, 1 insertion(+)
> 
> I think you forgot to mention - in cover letter - that this depends on
> my Samsung SPI bindings conversion to dtschema.

It's written in the cover letter:

"Note: This series is depended on [1] patches which adds
support of FSD SoC and on Krzysztof's v5 [2] of spi schema
changes"

Alim, you can also add:

Reviewed-by: Andi Shyti <andi@etezian.org>

Thank you,
Andi
