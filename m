Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E869584D48
	for <lists+linux-spi@lfdr.de>; Fri, 29 Jul 2022 10:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235127AbiG2IRD (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 29 Jul 2022 04:17:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbiG2IRD (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 29 Jul 2022 04:17:03 -0400
Received: from 10.mo548.mail-out.ovh.net (10.mo548.mail-out.ovh.net [46.105.77.235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6384B282
        for <linux-spi@vger.kernel.org>; Fri, 29 Jul 2022 01:17:01 -0700 (PDT)
Received: from mxplan5.mail.ovh.net (unknown [10.109.143.183])
        by mo548.mail-out.ovh.net (Postfix) with ESMTPS id 69E68227C8;
        Fri, 29 Jul 2022 07:39:23 +0000 (UTC)
Received: from kaod.org (37.59.142.102) by DAG4EX2.mxp5.local (172.16.2.32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.9; Fri, 29 Jul
 2022 09:39:21 +0200
Authentication-Results: garm.ovh; auth=pass (GARM-102R0041218b063-a24c-41c6-87ed-1d34e970e8a6,
                    FAFF5065920E43DA0D2CF6C40E58A39B80E28978) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 90.89.72.120
Message-ID: <32c4045d-7fce-5954-9710-4f6b0c6b0d2a@kaod.org>
Date:   Fri, 29 Jul 2022 09:39:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH linux dev-5.15] soc: aspeed: abr: Add sysfs attrs for
 flash toggle
Content-Language: en-US
To:     Andrew Jeffery <andrew@aj.id.au>,
        Jian Zhang <zhangjian.3032@bytedance.com>,
        <openbmc@lists.ozlabs.org>, Joel Stanley <joel@jms.id.au>
CC:     <zhangjian_linux@163.com>, Mark Brown <broonie@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:SPI SUBSYSTEM" <linux-spi@vger.kernel.org>,
        "moderated list:ARM/ASPEED MACHINE SUPPORT" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/ASPEED MACHINE SUPPORT" 
        <linux-aspeed@lists.ozlabs.org>
References: <20220501105644.355062-1-zhangjian.3032@bytedance.com>
 <62143648-8a90-4ff4-bfe1-f311b40cd50c@www.fastmail.com>
From:   =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <62143648-8a90-4ff4-bfe1-f311b40cd50c@www.fastmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.102]
X-ClientProxiedBy: DAG9EX1.mxp5.local (172.16.2.81) To DAG4EX2.mxp5.local
 (172.16.2.32)
X-Ovh-Tracer-GUID: a6453bd3-2138-4703-b325-6e2aced1d2b3
X-Ovh-Tracer-Id: 10280310576058174386
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvfedrvdduiedgieegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgihesthejredttdefjeenucfhrhhomhepveorughrihgtpgfnvggpifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeelleeiiefgkeefiedtvdeigeetueetkeffkeelheeugfetteegvdekgfehgffgkeenucfkpheptddrtddrtddrtddpfeejrdehledrudegvddruddtvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphhouhhtpdhhvghlohepmhigphhlrghnhedrmhgrihhlrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegtlhhgsehkrghougdrohhrghdpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdgrshhpvggvugeslhhishhtshdrohiilhgrsghsrdhorhhgpdfovfetjfhoshhtpehmohehgeek
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello,

On 7/29/22 04:37, Andrew Jeffery wrote:
> Hi Jian Zhang,
> 
> On Sun, 1 May 2022, at 20:26, Jian Zhang wrote:
>> Implement the flash toggle function in soc ast2600.
>> Add two sysfs attrs named "access_primary" and "access_backup"
> 
> If you're proposing this patch for upstream then it needs to be based on
> an upstream kernel tree, not the OpenBMC kernel tree. You also should
> not use e.g. `linux dev-5.15` in the patch subject prefix, as that would
> be inappropriate for an upstream patch.
> 
> As you're adding sysfs attributes you'll also need to add the
> corresponding ABI documentation.

Yes. I think we need to discuss the ABI/sysfs files a bit. I am not
sure we should toggle the sysfs files depending on the boot mode :
primary vs. alternate. We could have the same files always and return
EIO if some conditions are not met. Something like :

* boot mode : primary/alternate. Write changes the next boot.
* watchdog management

Also, there is no need to introduce a new include file with large
inline functions.

Thanks,

C.
