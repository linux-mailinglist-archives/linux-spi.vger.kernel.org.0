Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F11363DCEE7
	for <lists+linux-spi@lfdr.de>; Mon,  2 Aug 2021 05:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232066AbhHBD1U (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 1 Aug 2021 23:27:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232065AbhHBD1S (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 1 Aug 2021 23:27:18 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F488C0613D5
        for <linux-spi@vger.kernel.org>; Sun,  1 Aug 2021 20:27:09 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id s22-20020a17090a1c16b0290177caeba067so3779612pjs.0
        for <linux-spi@vger.kernel.org>; Sun, 01 Aug 2021 20:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TccySR4d9f6K2bAZSrfCed+rWi5fYVMvW07bdg4ljSg=;
        b=wA5XdmZs04xMdzfn8U8bqGmZGAXLG9rpdrtGI6xEU9M3gkKAEajXWdDTyBRMB9YfYb
         KPaWosNiKdc1rYyKsQZ+qpyEUGNFTBYn2LfEmWQxmGqC7A4q+/d34+uJzmYKryDop33p
         0g1Hb9R2ZCh9rHKAM9wlcRAwn3MJRszFv7VDRVLR4iHeEgjpOI3heVWUD49RO9lYq5Az
         cP5+0ICKtJehdimAQsbm4xuMxLHlcBiaS+pKhJmIsBVlsuIEhJkK2jTR4i6w5VmLW6ON
         rNyn/DlC7ja3csj05f1WbMSZaVQ7+NQr3b7e18XtAbG98QdRJZDdln8+keTvtFGEtiPY
         Rsnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TccySR4d9f6K2bAZSrfCed+rWi5fYVMvW07bdg4ljSg=;
        b=kp1S2UUevAL/t2BjJOFyGSAwzjowH8mqNNyHjiSc0cnEBdw/T+/ylgBLYML4U3IJ0n
         p4KWY3/67iIMncA3TXEP0fxgxEvtc3LRjnrEFn79HF+QNOe/T/cr9DG4Z3cxhukTeEeX
         F66D8raBCFoV95RGbvV6pqNWwHNAFAqW3NtMOdxgaGL3JRgwqfdqQnq0GtCyta4K5gYh
         5WFWSWhFt//Hs935FVzxZql1UFHYF7x2IqQRWtuVP7FTrR2DTadA8PCd7ihRpJm/hl6T
         z/gmpw0L/PbKJ+ThZoJrJutSo2mNaWFE12I5KtfVEIR+LYdNkhUMcWf8OoiCDfZqkPF/
         Ixbg==
X-Gm-Message-State: AOAM533MFQlxgxvxi4VboNPA7tYMhaxuumhancdCOMlqcWCedNeL//V/
        17RaU9PkTRj7XAWMmjirwbFexg==
X-Google-Smtp-Source: ABdhPJxuUMNiBNw7iVAnGTeUxFYDuL3xz++58ek1lZ6xPw5MR9NriVo4l+8Jn6Tf0aqwz0SNLCfyeA==
X-Received: by 2002:a05:6a00:aca:b029:392:9c79:3a39 with SMTP id c10-20020a056a000acab02903929c793a39mr14779697pfl.57.1627874828655;
        Sun, 01 Aug 2021 20:27:08 -0700 (PDT)
Received: from google.com ([2401:fa00:1:10:4e86:5558:a761:961])
        by smtp.gmail.com with ESMTPSA id a22sm9091534pfv.113.2021.08.01.20.27.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Aug 2021 20:27:08 -0700 (PDT)
Date:   Mon, 2 Aug 2021 11:27:05 +0800
From:   Tzung-Bi Shih <tzungbi@google.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peter Hess <peter.hess@ph-home.de>,
        Frank Wunderlich <frank-w@public-files.de>,
        Hsin-Yi Wang <hsinyi@google.com>
Subject: Re: [PATCH] spi: mediatek: Fix fifo transfer
Message-ID: <YQdmCaySpW4Dpz0t@google.com>
References: <20210802030023.1748777-1-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210802030023.1748777-1-linux@roeck-us.net>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sun, Aug 01, 2021 at 08:00:23PM -0700, Guenter Roeck wrote:
> Fixes: 3a70dd2d0503 ("spi: mediatek: fix fifo rx mode")
> Cc: Peter Hess <peter.hess@ph-home.de>
> Cc: Frank Wunderlich <frank-w@public-files.de>
> Cc: Tzung-Bi Shih <tzungbi@google.com>
> Cc: Hsin-Yi Wang <hsinyi@google.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Tested-by: Tzung-Bi Shih <tzungbi@google.com>
