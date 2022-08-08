Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE06058C4B2
	for <lists+linux-spi@lfdr.de>; Mon,  8 Aug 2022 10:09:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233892AbiHHIJV (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 8 Aug 2022 04:09:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234640AbiHHIJT (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 8 Aug 2022 04:09:19 -0400
Received: from 2.mo560.mail-out.ovh.net (2.mo560.mail-out.ovh.net [188.165.53.149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65F59643E
        for <linux-spi@vger.kernel.org>; Mon,  8 Aug 2022 01:09:17 -0700 (PDT)
Received: from player791.ha.ovh.net (unknown [10.109.146.19])
        by mo560.mail-out.ovh.net (Postfix) with ESMTP id 9C8A223FEA
        for <linux-spi@vger.kernel.org>; Mon,  8 Aug 2022 08:09:15 +0000 (UTC)
Received: from etezian.org (bbcs-175-223.cust.wingo.ch [178.238.175.223])
        (Authenticated sender: andi@etezian.org)
        by player791.ha.ovh.net (Postfix) with ESMTPSA id 0B9A62D4A25E6;
        Mon,  8 Aug 2022 08:09:02 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass (GARM-101G004470e5d2f-4ec8-446b-9b2c-f538d1afd209,
                    D07DC7BC5756341CF3D6D9F7D18BF56C80B463DD) smtp.auth=andi@etezian.org
X-OVh-ClientIp: 178.238.175.223
Date:   Mon, 8 Aug 2022 10:09:02 +0200
From:   Andi Shyti <andi@etezian.org>
To:     Chanho Park <chanho61.park@samsung.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andi Shyti <andi@etezian.org>, Mark Brown <broonie@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Adithya K V <adithya.kv@samsung.com>,
        kernel test robot <lkp@intel.com>, linux-spi@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: s3c64xx: correct dma_chan pointer initialization
Message-ID: <YvDEngXWqFp4lv7i@intel.intel>
References: <CGME20220808004253epcas2p3937171a6f89a765d67d5cc7b55afb89a@epcas2p3.samsung.com>
 <20220808004851.25122-1-chanho61.park@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220808004851.25122-1-chanho61.park@samsung.com>
X-Ovh-Tracer-Id: 14171420654007487195
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvfedrvdefkedgtddvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheptehnughiucfuhhihthhiuceorghnughisegvthgviihirghnrdhorhhgqeenucggtffrrghtthgvrhhnpeejgfelgeekieffjeegveeuvdehgeelveetveejudffvedvleehvdefleehudelueenucfkpheptddrtddrtddrtddpudejkedrvdefkedrudejhedrvddvfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphhouhhtpdhhvghlohepphhlrgihvghrjeeluddrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegrnhguihesvghtvgiiihgrnhdrohhrghdpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdhsphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdfovfetjfhoshhtpehmohehiedt
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Chanho,

On Mon, Aug 08, 2022 at 09:48:51AM +0900, Chanho Park wrote:
> Use NULL for dma channel pointer initialization instead of plain integer.
> 
> sparse warnings: (new ones prefixed by >>)
> >> drivers/spi/spi-s3c64xx.c:387:34: sparse: sparse: Using plain integer as NULL pointer
>    drivers/spi/spi-s3c64xx.c:388:34: sparse: sparse: Using plain integer as NULL pointer
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Fixes: 82295bc0d192 ("spi: s3c64xx: move dma_release_channel to unprepare")
> Fixes: f52b03c70744 ("spi: s3c64xx: requests spi-dma channel only during data transfer")
> Signed-off-by: Chanho Park <chanho61.park@samsung.com>

Reviewed-by: Andi Shyti <andi@etezian.org>

Thanks,
Andi
