Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83EBE7819AC
	for <lists+linux-spi@lfdr.de>; Sat, 19 Aug 2023 15:17:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232646AbjHSNRW (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 19 Aug 2023 09:17:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232603AbjHSNRW (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 19 Aug 2023 09:17:22 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DCA02122E
        for <linux-spi@vger.kernel.org>; Sat, 19 Aug 2023 06:16:11 -0700 (PDT)
Received: from i53875a83.versanet.de ([83.135.90.131] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1qXLoE-0004Ut-7k; Sat, 19 Aug 2023 15:16:06 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     linux-spi@vger.kernel.org,
        Yang Yingliang <yangyingliang@huawei.com>
Cc:     broonie@kernel.org, geert@linux-m68k.org, lukas@wunner.de,
        yangyingliang@huawei.com
Subject: Re: [PATCH -next v3 13/23] spi: rockchip: switch to use modern name
Date:   Sat, 19 Aug 2023 15:16:05 +0200
Message-ID: <6008610.31r3eYUQgx@diego>
In-Reply-To: <20230818093154.1183529-14-yangyingliang@huawei.com>
References: <20230818093154.1183529-1-yangyingliang@huawei.com>
 <20230818093154.1183529-14-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Am Freitag, 18. August 2023, 11:31:44 CEST schrieb Yang Yingliang:
> Change legacy name master/slave to modern name host/target or controller.
> 
> No functional changed.
> 
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>

I don't have a preference on these naming things, but for what it's worth
if people want to rename things:

Acked-by: Heiko Stuebner <heiko@sntech.e>



