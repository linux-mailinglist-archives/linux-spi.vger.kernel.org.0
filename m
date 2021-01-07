Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 316F42ED5A8
	for <lists+linux-spi@lfdr.de>; Thu,  7 Jan 2021 18:31:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728542AbhAGRas (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 7 Jan 2021 12:30:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728338AbhAGRas (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 7 Jan 2021 12:30:48 -0500
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7BD7C0612F5
        for <linux-spi@vger.kernel.org>; Thu,  7 Jan 2021 09:30:07 -0800 (PST)
Received: by mail-il1-x129.google.com with SMTP id n9so7524987ili.0
        for <linux-spi@vger.kernel.org>; Thu, 07 Jan 2021 09:30:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=73649eJTBFUD2IK37c/cv6X9hiG+wNAZHTq86G2mAmk=;
        b=CmM3ePgxc8oGXzyPTiOXR5SAufN4NRtzOtciTJTdiD4QNn2y8XP+7AKpsYD2Odpeju
         rLDAw6agzIUc9ZM5n55YpVx2ppxhmLj9H+ijhARINGcbP9NJGKFhp2K/p7XYhahVFgWW
         OYwJSmrUkaJTlhCDLVaMceSUC07QYoLicvZVfM+VNB6pOWC7uMDa4hKRStyqc7RiE2bo
         6MVdEtbknnJXOMpYepeMwQfcZ7MZnyN/k6SfQ0sd1DAyuymU6zev7zrJF7TkwglfiZFq
         iojBkzsi8rXA5JNLtlJ/4oVCphKPnxBCpVMzWLfK/N8ozfQ+UtzzmIFThwqDgWsOC0ta
         qGFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=73649eJTBFUD2IK37c/cv6X9hiG+wNAZHTq86G2mAmk=;
        b=by47cD8Wmd1t6EN1uK9ECgCiRF4urdrGXYRsMEyljxIzKtuAP8h/kUtYpM/DJUw9wA
         7Fhi0nsaqGGJ0BZ4lYJvuYQI7j/tRFWtPPw4XvFRLmiTIfJqEitRmKYh//LJbwlCSXXm
         NvVXa2D3I540eAq3BfsiqqBgj2j41sQsPOXwwlWASJ1ibU+IiKWkWKDaKBPmReUMI3UU
         MfKzXzjqyn1XFfbAg1TMj9NNRltN2sWzZiw01NItssYzBa7MywfMtLSrZn7X+mVP2VRt
         cOPBFbFuCKlLbsYw/lQAy/JNxE8nOUkt/5XEaRpWNKrirReq+qgjcb2+7AEUcU8ot2lU
         zezg==
X-Gm-Message-State: AOAM533qsDFUy6FdJlDFxWuhVfRq2/Z8JYnK3vMIGYyO+kdUpIqwhxUG
        WgyWJmpA39NHia5o9ZKMbW7NvDeHAPk=
X-Google-Smtp-Source: ABdhPJwd0WM01Za7Scnmwo/6ZrIVuvFbd/Jabwk7H0Wro/STkg5pPeZpYphcUzP8VsGKFGfcQuAJCw==
X-Received: by 2002:a92:444c:: with SMTP id a12mr10291010ilm.53.1610040606996;
        Thu, 07 Jan 2021 09:30:06 -0800 (PST)
Received: from ubuntu-m3-large-x86 ([2604:1380:45f1:1d00::1])
        by smtp.gmail.com with ESMTPSA id l6sm5334420ili.78.2021.01.07.09.30.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 09:30:06 -0800 (PST)
Date:   Thu, 7 Jan 2021 10:30:04 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Yanteng Si <siyanteng@loongson.cn>
Cc:     Mark Brown <broonie@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-spi@vger.kernel.org, Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Yanteng Si <siyanteng@gmail.com>
Subject: Re: [PATCH] SPI: Fix distinct pointer types warning for ARCH=MIPS
Message-ID: <20210107173004.GA2169893@ubuntu-m3-large-x86>
References: <20210107115704.3835282-1-siyanteng@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210107115704.3835282-1-siyanteng@loongson.cn>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, Jan 07, 2021 at 07:57:04PM +0800, Yanteng Si wrote:
> Fix a new warning report by build for make ARCH=MIPS allmodconfig:
> 
> drivers/spi/spi-cadence-quadspi.c: In function 'cqspi_direct_read_execute':
>  ./include/linux/minmax.h:18:28: warning: comparison of distinct pointer types lacks a cast
>     18 |  (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
>        |                            ^~
>  ./include/linux/minmax.h:32:4: note: in expansion of macro '__typecheck'
>     32 |   (__typecheck(x, y) && __no_side_effects(x, y))
>        |    ^~~~~~~~~~~
>  ./include/linux/minmax.h:42:24: note: in expansion of macro '__safe_cmp'
>     42 |  __builtin_choose_expr(__safe_cmp(x, y), \
>        |                        ^~~~~~~~~~
>  ./include/linux/minmax.h:58:19: note: in expansion of macro '__careful_cmp'
>     58 | #define max(x, y) __careful_cmp(x, y, >)
>        |                   ^~~~~~~~~~~~~
>  drivers/spi/spi-cadence-quadspi.c:1153:24: note: in expansion of macro 'max'
>   1153 |       msecs_to_jiffies(max(len, 500UL)))) {
>        |                        ^~~
> 
> "len" is unsigned,however,"500" is unsigned long.
> 
> Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
> ---
>  drivers/spi/spi-cadence-quadspi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
> index 06a65e9a8a60..576610ba1118 100644
> --- a/drivers/spi/spi-cadence-quadspi.c
> +++ b/drivers/spi/spi-cadence-quadspi.c
> @@ -1150,7 +1150,7 @@ static int cqspi_direct_read_execute(struct cqspi_flash_pdata *f_pdata,
>  
>  	dma_async_issue_pending(cqspi->rx_chan);
>  	if (!wait_for_completion_timeout(&cqspi->rx_dma_complete,
> -					 msecs_to_jiffies(max(len, 500UL)))) {
> +					 msecs_to_jiffies(max(len, 500U)))) {
>  		dmaengine_terminate_sync(cqspi->rx_chan);
>  		dev_err(dev, "DMA wait_for_completion_timeout\n");
>  		ret = -ETIMEDOUT;
> -- 
> 2.27.0
> 

Isn't this just going to cause warnings on 64-bit platforms now because
size_t is defined as unsigned long and it will now be compared against
unsigned int? This fix should work for everyone, not sure how pretty it
is though.

Cheers,
Nathan

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 06a65e9a8a60..af13c0025bf5 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -1150,7 +1150,7 @@ static int cqspi_direct_read_execute(struct cqspi_flash_pdata *f_pdata,
 
 	dma_async_issue_pending(cqspi->rx_chan);
 	if (!wait_for_completion_timeout(&cqspi->rx_dma_complete,
-					 msecs_to_jiffies(max(len, 500UL)))) {
+					 msecs_to_jiffies(max_t(size_t, len, 500)))) {
 		dmaengine_terminate_sync(cqspi->rx_chan);
 		dev_err(dev, "DMA wait_for_completion_timeout\n");
 		ret = -ETIMEDOUT;
