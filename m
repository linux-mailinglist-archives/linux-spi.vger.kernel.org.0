Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F08015E7381
	for <lists+linux-spi@lfdr.de>; Fri, 23 Sep 2022 07:50:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbiIWFuC (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 23 Sep 2022 01:50:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiIWFuB (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 23 Sep 2022 01:50:01 -0400
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [IPv6:2a01:37:3000::53df:4ef0:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CB6880497
        for <linux-spi@vger.kernel.org>; Thu, 22 Sep 2022 22:49:59 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id C12F42801DFED;
        Fri, 23 Sep 2022 07:49:57 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id AA7BC4EA1F; Fri, 23 Sep 2022 07:49:57 +0200 (CEST)
Date:   Fri, 23 Sep 2022 07:49:57 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-spi@vger.kernel.org, broonie@kernel.org,
        michal.simek@xilinx.com
Subject: Re: [PATCH -next] spi: xilinx: Switch to use devm_spi_alloc_master()
Message-ID: <20220923054957.GA15581@wunner.de>
References: <20220920114615.2681751-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220920114615.2681751-1-yangyingliang@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, Sep 20, 2022 at 07:46:15PM +0800, Yang Yingliang wrote:
> Switch to use devm_spi_alloc_master() to simpify error path.
> 
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>

Reviewed-by: Lukas Wunner <lukas@wunner.de>
