Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F3A117F12E
	for <lists+linux-spi@lfdr.de>; Tue, 10 Mar 2020 08:40:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbgCJHkb (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 10 Mar 2020 03:40:31 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:53765 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726205AbgCJHkb (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 10 Mar 2020 03:40:31 -0400
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id DE44123EDA;
        Tue, 10 Mar 2020 08:40:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1583826028;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JRZcHvgvLH/G0fKRtKlNaPs+QGkfcGvNQB9hzhsnhBg=;
        b=c51c6shN/c0FIr4+mKsyzcFl89c9rYlfnOpudXT37KFluN9MilPkLrxaap/grE1XAkqrvu
        rVuR8SXPMgzDHhUEdxOqETq6rTS73RoDT696p/KTcq86dgy397nD/skC9Y3fR3ZOxikH3s
        aYoXZZRZRQPKMZ6OmI0/F8pFSN5lOtg=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 10 Mar 2020 08:40:28 +0100
From:   Michael Walle <michael@walle.cc>
To:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org
Cc:     Sumit Semwal <sumit.semwal@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Vladimir Oltean <vladimir.oltean@nxp.com>
Subject: Re: [PATCH] spi: spi-fsl-dspi: fix DMA mapping
In-Reply-To: <20200310073313.21277-1-michael@walle.cc>
References: <20200310073313.21277-1-michael@walle.cc>
Message-ID: <4beb5200a76f2d817be7276444543de4@walle.cc>
X-Sender: michael@walle.cc
User-Agent: Roundcube Webmail/1.3.10
X-Spamd-Bar: /
X-Spam-Status: No, score=-0.10
X-Rspamd-Server: web
X-Spam-Score: -0.10
X-Rspamd-Queue-Id: DE44123EDA
X-Spamd-Result: default: False [-0.10 / 15.00];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         DKIM_SIGNED(0.00)[];
         RCPT_COUNT_SEVEN(0.00)[8];
         NEURAL_HAM(-0.00)[-0.593];
         RCVD_COUNT_ZERO(0.00)[0];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         MID_RHS_MATCH_FROM(0.00)[]
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Am 2020-03-10 08:33, schrieb Michael Walle:
> Use the correct device to request the DMA mapping. Otherwise the IOMMU
> doesn't get the mapping and it will generate a page fault.
> 
> The error messages look like:
> [    3.008452] arm-smmu 5000000.iommu: Unhandled context fault:
> fsr=0x402, iova=0xf9800000, fsynr=0x3f0022, cbfrsynra=0x828, cb=8
> [    3.020123] arm-smmu 5000000.iommu: Unhandled context fault:
> fsr=0x402, iova=0xf9800000, fsynr=0x3f0022, cbfrsynra=0x828, cb=8
> 
> This was tested on a custom board with a LS1028A SoC.

Oh fu.. please disregard this patch. DMA mapping still isn't working.
Somehow I missed that the transfer mode was turned back to its default
XSPI mode.

-michael

