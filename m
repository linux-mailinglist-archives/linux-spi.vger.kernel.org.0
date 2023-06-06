Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63F0172349B
	for <lists+linux-spi@lfdr.de>; Tue,  6 Jun 2023 03:37:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233839AbjFFBhB (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 5 Jun 2023 21:37:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233831AbjFFBg6 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 5 Jun 2023 21:36:58 -0400
X-Greylist: delayed 433 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 05 Jun 2023 18:36:56 PDT
Received: from 5.mo576.mail-out.ovh.net (5.mo576.mail-out.ovh.net [46.105.43.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62E2910E
        for <linux-spi@vger.kernel.org>; Mon,  5 Jun 2023 18:36:55 -0700 (PDT)
Received: from director6.ghost.mail-out.ovh.net (unknown [10.109.156.41])
        by mo576.mail-out.ovh.net (Postfix) with ESMTP id 527E521446
        for <linux-spi@vger.kernel.org>; Tue,  6 Jun 2023 01:21:47 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-4prwk (unknown [10.110.171.23])
        by director6.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 5E87C1FDB4;
        Tue,  6 Jun 2023 01:21:44 +0000 (UTC)
Received: from etezian.org ([37.59.142.101])
        by ghost-submission-6684bf9d7b-4prwk with ESMTPSA
        id JjxENSiKfmRbAwAAf+gIYQ
        (envelope-from <andi@etezian.org>); Tue, 06 Jun 2023 01:21:44 +0000
Authentication-Results: garm.ovh; auth=pass (GARM-101G0048c33b239-8606-43e5-a295-42be09ae1121,
                    89204758E3263BAD5AD9D1E9907359A1AF45ECBD) smtp.auth=andi@etezian.org
X-OVh-ClientIp: 178.238.172.216
From:   Andi Shyti <andi.shyti@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        Andi Shyti <andi.shyti@kernel.org>
Subject: [PATCH 0/2] spi: s3c64xx: Cleanups
Date:   Tue,  6 Jun 2023 03:20:49 +0200
Message-Id: <20230606012051.2139333-1-andi.shyti@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 9956051402834381383
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvhedrgedttddggeefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomheptehnughiucfuhhihthhiuceorghnughirdhshhihthhisehkvghrnhgvlhdrohhrgheqnecuggftrfgrthhtvghrnheptdevueeiheeftedujefhheelieejvdevteelfefhheeutdelkedtveejudejgfdvnecukfhppeduvdejrddtrddtrddupddujeekrddvfeekrddujedvrddvudeipdefjedrheelrddugedvrddutddunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpeeorghnughisegvthgviihirghnrdhorhhgqedpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdhsphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdfovfetjfhoshhtpehmohehjeeipdhmohguvgepshhmthhpohhuth
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi,

two small cleanups in the probe function. The first puts in use
the managed spi master allocation while the second implements the
dev_err_probe() function.

Thanks,
Andi

Andi Shyti (2):
  spi: s3c64xx: Use the managed spi master allocation function
  spi: s3c64xx: Use dev_err_probe()

 drivers/spi/spi-s3c64xx.c | 81 +++++++++++++++------------------------
 1 file changed, 30 insertions(+), 51 deletions(-)

-- 
2.40.1

