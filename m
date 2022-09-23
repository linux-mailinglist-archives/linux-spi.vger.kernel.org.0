Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FA035E7379
	for <lists+linux-spi@lfdr.de>; Fri, 23 Sep 2022 07:33:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbiIWFdP (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 23 Sep 2022 01:33:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbiIWFdP (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 23 Sep 2022 01:33:15 -0400
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF23F55BF
        for <linux-spi@vger.kernel.org>; Thu, 22 Sep 2022 22:33:13 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id 8EAA1280994B3;
        Fri, 23 Sep 2022 07:33:12 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 7733A4E9FF; Fri, 23 Sep 2022 07:33:12 +0200 (CEST)
Date:   Fri, 23 Sep 2022 07:33:12 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-spi@vger.kernel.org, broonie@kernel.org
Subject: Re: [PATCH -next 0/6] spi: Switch to use devm_spi_alloc_master() in
 some drivers
Message-ID: <20220923053312.GA817@wunner.de>
References: <20220920134819.2981033-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220920134819.2981033-1-yangyingliang@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, Sep 20, 2022 at 09:48:13PM +0800, Yang Yingliang wrote:
> This patchset is trying to replace spi_alloc_master() with
> devm_spi_alloc_master() in some spi drivers. With this helper,
> spi_master_put() is called in devres_release_all() whenever
> the device is unbound, so the spi_master_put() in error path
> can be removed.
> 
> Yang Yingliang (6):
>   spi: oc-tiny: Switch to use devm_spi_alloc_master()
>   spi: ath79: Switch to use devm_spi_alloc_master()
>   spi: omap-uwire: Switch to use devm_spi_alloc_master()
>   spi: ppc4xx: Switch to use devm_spi_alloc_master()
>   spi: sh-sci: Switch to use devm_spi_alloc_master()
>   spi: altera: Switch to use devm_spi_alloc_master()

I'm withdrawing my objections to patches 1, 2 and 3:
I failed to appreciate that these drivers use spi_bitbang_start(),
which takes an extra reference on the controller.  Sorry for the noise.

Whole series is
Reviewed-by: Lukas Wunner <lukas@wunner.de>

This pertains to v1 of the series, not v2 (which incorrectly uses
__devm_spi_alloc_controller()).

Thanks,

Lukas
