Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD239696630
	for <lists+linux-spi@lfdr.de>; Tue, 14 Feb 2023 15:12:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233369AbjBNOMn (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 14 Feb 2023 09:12:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233318AbjBNOMV (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 14 Feb 2023 09:12:21 -0500
X-Greylist: delayed 643 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 14 Feb 2023 06:11:48 PST
Received: from out-26.mta1.migadu.com (out-26.mta1.migadu.com [IPv6:2001:41d0:203:375::1a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 380B727D4E
        for <linux-spi@vger.kernel.org>; Tue, 14 Feb 2023 06:11:47 -0800 (PST)
Message-ID: <e9fc3b01-4132-a224-4bbf-9b86ce314e8b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1676382960;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xhGNsWwBjbALl1XGGkzHbCvyqw6Vr8ZjETBZ4GXc+YA=;
        b=MBAxYY7axSCYPCOhS5O26s3JdKh3+r5bNTiL5Pjf/bLmwTpzmdE6CidLcfbwaXMUUImwCS
        ATNY2JAzp6LWN2e/S3NHCTMuhZjC1Hx5u8pILOhLlP2D8shSa82lCs9kZukexefuWYnKKX
        1HIx2wA2POEwrK4givuXin5PGTgUJ3w=
Date:   Tue, 14 Feb 2023 13:55:56 +0000
MIME-Version: 1.0
Subject: Re: [PATCH] spi: xilinx: add force_irq for QSPI mode
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
References: <20230209211321.1427968-1-vadfed@meta.com>
 <Y+uMNxQmi5lg10CN@sirena.org.uk>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc:     linux-spi@vger.kernel.org
In-Reply-To: <Y+uMNxQmi5lg10CN@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_20,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 14/02/2023 13:27, Mark Brown wrote:
> On Thu, Feb 09, 2023 at 01:13:21PM -0800, Vadim Fedorenko wrote:
>> Xilinx PG158 page 80 [1] states that master transaction inhibit bit must
>> be set to properly setup the transaction in QSPI mode. Add the force_irq
>> flag to follow this sequence.
> 
> This doesn't apply against current code, please check and resend.

Oh, yep, it has some overlap with devm_spi_alloc_master() commit. V2 is 
on the way.
