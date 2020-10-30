Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19E242A0651
	for <lists+linux-spi@lfdr.de>; Fri, 30 Oct 2020 14:18:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbgJ3NSc (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 30 Oct 2020 09:18:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbgJ3NSb (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 30 Oct 2020 09:18:31 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F5C8C0613CF;
        Fri, 30 Oct 2020 06:18:31 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id g25so5788012edm.6;
        Fri, 30 Oct 2020 06:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xFyS46X9kh1NWbr14wv/nJDNDTn+YMS1XnTi/wd21tc=;
        b=P+FmJ20YVKNwOxLSH405xuHUQaKuOy3JPZkJ7knoWdc55cdKPkQ2m/yQqqShC245wH
         ai0bz3nN+wWVhmf8cMdIRvuVuE/BXlu0kgSoXAF7pmSiSICz3rFHlW3+HH4jD02mYBbt
         t30FTHlCL2a4us/STblZUIBre43bprKuqp4TmCl3gl5eiZCW5LAT483JZUFnGEZcMwiM
         QePOFv41wS7f+9R4wAfYkQHUf+JbmthKm0ZQ0grFfw9KkVsHyoB0kjTvgMoNezuWix2G
         vzZwDDVZhBVz7oHMhmAFfdeYUzw+rbI/xWkkuDFE+JEObVzlBnH/vIKEx8qo5hf3ToaT
         kSPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xFyS46X9kh1NWbr14wv/nJDNDTn+YMS1XnTi/wd21tc=;
        b=owIqR+gJ91fFno+KqijaM/fCt5clFmFHofObTtdWFPTOOIkwh8V6UWbID7osFmFcgy
         zNMMVpL3B+8efz5FAvEA5kR1gjDDTJCLpsDKt6mL825Qzu7fX2cBXn/b14qmCcBucBYm
         TNNE88J95GOTRd4ZGH0udcxojIDOmyfZSiQ4dlRQwyBtEjO7/f9TWkXmjwdIVqFvXcDu
         dTq5cYTxVsnqpjOpw4WN7F+b6ubzEZZ2tn5J57WufEZjTMdWbA0HPK4+Lzyq9irZpKNz
         osn+mSUZwnMBeLZ4IYF6mVJDClWbxelYQ+oKmJ2i4o7pkTpul5B/xbPLP8G7+Cb9y1wk
         u/hw==
X-Gm-Message-State: AOAM530QsPwV4myB64smm/E6oLRQmVdXGQ54ExIlKSkn2V3hIm1v8+Ky
        jUldFq3VnUYNO/vrGJQ5KV4=
X-Google-Smtp-Source: ABdhPJzaXy5QSpoB8t3JkIfwtsmciopVOa8tTohH8Nim0ujw8CN0Ue3zL+ME2f3zp5jCLj3ELJiGIw==
X-Received: by 2002:a50:9e29:: with SMTP id z38mr2358139ede.220.1604063910134;
        Fri, 30 Oct 2020 06:18:30 -0700 (PDT)
Received: from skbuf ([188.25.2.177])
        by smtp.gmail.com with ESMTPSA id c17sm3114223edv.19.2020.10.30.06.18.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2020 06:18:29 -0700 (PDT)
Date:   Fri, 30 Oct 2020 15:18:28 +0200
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Qiang Zhao <qiang.zhao@nxp.com>
Cc:     broonie@kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: fsl-dspi: fix NULL pointer dereference
Message-ID: <20201030131828.7h25eps7wuf655eh@skbuf>
References: <20201029084035.19604-1-qiang.zhao@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201029084035.19604-1-qiang.zhao@nxp.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, Oct 29, 2020 at 04:40:35PM +0800, Qiang Zhao wrote:
> From: Zhao Qiang <qiang.zhao@nxp.com>
> 
> Since commit 530b5affc675 ("spi: fsl-dspi: fix use-after-free in
> remove path"), this driver causes a kernel oops:
> 
> [   64.587431] Unable to handle kernel NULL pointer dereference at
> virtual address 0000000000000020
> [..]
> [   64.756080] Call trace:
> [   64.758526]  dspi_suspend+0x30/0x78
> [   64.762012]  platform_pm_suspend+0x28/0x70
> [   64.766107]  dpm_run_callback.isra.19+0x24/0x70
> [   64.770635]  __device_suspend+0xf4/0x2f0
> [   64.774553]  dpm_suspend+0xec/0x1e0
> [   64.778036]  dpm_suspend_start+0x80/0xa0
> [   64.781957]  suspend_devices_and_enter+0x118/0x4f0
> [   64.786743]  pm_suspend+0x1e0/0x260
> [   64.790227]  state_store+0x8c/0x118
> [   64.793712]  kobj_attr_store+0x18/0x30
> [   64.797459]  sysfs_kf_write+0x40/0x58
> [   64.801118]  kernfs_fop_write+0x148/0x240
> [   64.805126]  vfs_write+0xc0/0x230
> [   64.808436]  ksys_write+0x6c/0x100
> [   64.811833]  __arm64_sys_write+0x1c/0x28
> [   64.815753]  el0_svc_common.constprop.3+0x68/0x170
> [   64.820541]  do_el0_svc+0x24/0x90
> [   64.823853]  el0_sync_handler+0x118/0x168
> [   64.827858]  el0_sync+0x158/0x180
> 
> This is because since this commit, the drivers private data point to
> "dspi" instead of "ctlr", the codes in suspend and resume func were
> not modified correspondly.
> 
> Fixes: 530b5affc675 ("spi: fsl-dspi: fix use-after-free in remove path")
> Signed-off-by: Zhao Qiang <qiang.zhao@nxp.com>
> ---

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

Please resend with Mark's comment. I would prefer that you even remove
the stack trace completely and make it more obvious in the commit
message itself that the NULL pointer occurs during suspend/resume.
Somehow that managed to get obscured in your current version. It is also
not helpful at all that there already exists a commit titled 'spi:
fsl-dspi: fix NULL pointer dereference' on this driver. This causes
confusion for backporters. Please provide a unique commit message.
Thanks.
