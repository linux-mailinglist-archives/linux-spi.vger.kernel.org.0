Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FE335E731F
	for <lists+linux-spi@lfdr.de>; Fri, 23 Sep 2022 06:55:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbiIWEzM (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 23 Sep 2022 00:55:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiIWEzM (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 23 Sep 2022 00:55:12 -0400
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [IPv6:2a01:37:1000::53df:5f64:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E1AED58AF
        for <linux-spi@vger.kernel.org>; Thu, 22 Sep 2022 21:55:11 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id 7034B30003C74;
        Fri, 23 Sep 2022 06:55:07 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 56AEA4F1BA; Fri, 23 Sep 2022 06:55:07 +0200 (CEST)
Date:   Fri, 23 Sep 2022 06:55:07 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-spi@vger.kernel.org, broonie@kernel.org
Subject: Re: [PATCH -next 1/6] spi: oc-tiny: Switch to use
 devm_spi_alloc_master()
Message-ID: <20220923045507.GA5066@wunner.de>
References: <20220920134819.2981033-1-yangyingliang@huawei.com>
 <20220920134819.2981033-2-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220920134819.2981033-2-yangyingliang@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, Sep 20, 2022 at 09:48:14PM +0800, Yang Yingliang wrote:
> Switch to use devm_spi_alloc_master() to simpify error path.

That's not sufficient.  You also need to remove the call to
spi_master_put() from tiny_spi_remove(), lest you introduce
a use-after-free.

Thanks,

Lukas
