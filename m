Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5B2255FDD6
	for <lists+linux-spi@lfdr.de>; Wed, 29 Jun 2022 12:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbiF2KxS (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 29 Jun 2022 06:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233427AbiF2KxR (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 29 Jun 2022 06:53:17 -0400
Received: from 2.mo575.mail-out.ovh.net (2.mo575.mail-out.ovh.net [46.105.52.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEE40BA2
        for <linux-spi@vger.kernel.org>; Wed, 29 Jun 2022 03:53:16 -0700 (PDT)
Received: from player731.ha.ovh.net (unknown [10.110.208.89])
        by mo575.mail-out.ovh.net (Postfix) with ESMTP id 97BDA21757
        for <linux-spi@vger.kernel.org>; Wed, 29 Jun 2022 09:33:43 +0000 (UTC)
Received: from etezian.org (bbcs-175-223.cust.wingo.ch [178.238.175.223])
        (Authenticated sender: andi@etezian.org)
        by player731.ha.ovh.net (Postfix) with ESMTPSA id 129A42BD37AE9;
        Wed, 29 Jun 2022 09:33:31 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass (GARM-108S00272303c45-9778-4737-9c0f-c5461f48230c,
                    27473AD2557E96BAE247B01472F11916F8881100) smtp.auth=andi@etezian.org
X-OVh-ClientIp: 178.238.175.223
Date:   Wed, 29 Jun 2022 12:33:19 +0300
From:   Andi Shyti <andi@etezian.org>
To:     Chanho Park <chanho61.park@samsung.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andi Shyti <andi@etezian.org>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/4] spi: s3c64xx: support loopback mode
Message-ID: <YrwcXzROjBeDCjaO@jack.zhora.eu>
References: <20220628044222.152794-1-chanho61.park@samsung.com>
 <CGME20220628044432epcas2p2116480d15be87cb723855b7a39ced6dc@epcas2p2.samsung.com>
 <20220628044222.152794-2-chanho61.park@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220628044222.152794-2-chanho61.park@samsung.com>
X-Ovh-Tracer-Id: 2051108159235492376
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvfedrudegledgudeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtrodttddtvdenucfhrhhomheptehnughiucfuhhihthhiuceorghnughisegvthgviihirghnrdhorhhgqeenucggtffrrghtthgvrhhnpeefheefueelleeghfehgeeiudfgieefffdviedtjeduvdfhhfdthedvteeltdfhueenucfkpheptddrtddrtddrtddpudejkedrvdefkedrudejhedrvddvfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphhouhhtpdhhvghlohepphhlrgihvghrjeefuddrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegrnhguihesvghtvgiiihgrnhdrohhrghdpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdhsphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdfovfetjfhoshhtpehmohehjeeh
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Chanho,

On Tue, Jun 28, 2022 at 01:42:19PM +0900, Chanho Park wrote:
> Modern exynos SoCs can support self loopback mode via setting BIT(3) of
> MODE_CFG register. Previous SoCs don't have the bit so we need to add
> has_loopback field in the s3c64xx_spi_port_config. Exynos Auto v9 SoC
> has the bit and it will define the field to "true".
> When it is set, SPI_LOOP mode will be marked.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Chanho Park <chanho61.park@samsung.com>

Reviewed-by: Andi Shyti <andi@etezian.org>

Thanks,
Andi
