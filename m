Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B7EF29E9EA
	for <lists+linux-spi@lfdr.de>; Thu, 29 Oct 2020 12:03:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbgJ2LDW (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 29 Oct 2020 07:03:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726885AbgJ2LDW (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 29 Oct 2020 07:03:22 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DD9FC0613CF;
        Thu, 29 Oct 2020 04:03:22 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id l16so2621445eds.3;
        Thu, 29 Oct 2020 04:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WcrfQOvnwm3hHmWx9HizpVkHE+JWK+geEu+dtXdE4Xw=;
        b=UtuwjBvLlNUpsD3se90ifCs08CqSEeeLYrFoK36ssWdIonbCLnCLJiChXViRIXcauT
         iJb2+MqLHaapRTqa6CcLjcMHGxyWKwUVRc+Sbx9/zXjL/IuBgWukYJtHzV53UwWykM1C
         t6CRBG5gFEGDQy3rjmIqb+wzsLi/ITdV+cz60Ona84fzn5sTG+UfNk3RHd8KIgm9hHNT
         LbQWWL6npYnPI/9CBTnjlYP7yuaPXBYFL/1N02ikVfAqnrJWm0HnkvAeph4yKj9ycUNP
         kjoFTHtrMUw1OPTlrYOswaY26mwp05ao/oXyn0nKgN+5IsH3GCqpgQUKrQM2c7lgxqyn
         HISg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WcrfQOvnwm3hHmWx9HizpVkHE+JWK+geEu+dtXdE4Xw=;
        b=KrNNmGXOFiZUZFIiGS7OemgKZ/9z042VEgzLBmOY0j+jibuxmb0QeTekjBgmtdygcO
         V1YWvqjvrvkYOzH5q+7B6628a9aLajK+gz4/zgr/82WHXTBeht3lfdWoQ3suLpxfK4Uk
         szclxCYyCTVv8KIkHe8s8zwrbtSri4v35IxsGgGV0gDV+vb1KBrKfgqfR0bFx17WZKpB
         C5m6jjIj0i+lS+Q+LpaK5n3wusy9pVOB82kIbr1Uk81O5m1UDQU0CLTNUuXlecgNDMFs
         mhCP3Sceb9GFeLBJMbmnKsZII1dbm7+ZbP2wXDNwi+gtzIrB/7gBNOku149qvI3ng9o4
         SdIA==
X-Gm-Message-State: AOAM531FmdvV4P6UF7iDiOkWYu6KyPUtOywtUDAGHJ6UOKlB6gmd2Pqv
        SdL3gVaTxZMl3hL4p8Ut5Qs=
X-Google-Smtp-Source: ABdhPJxw5MmrQlt2KQcf9SNjOfKm7P0V8PmqYEBnUitxArOMp5TxPjlJZBSdKqVDaYZaqlFHO5Inlg==
X-Received: by 2002:aa7:cf95:: with SMTP id z21mr3282370edx.346.1603969400999;
        Thu, 29 Oct 2020 04:03:20 -0700 (PDT)
Received: from skbuf ([188.25.2.177])
        by smtp.gmail.com with ESMTPSA id 11sm1292385ejy.19.2020.10.29.04.03.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 04:03:20 -0700 (PDT)
Date:   Thu, 29 Oct 2020 13:03:19 +0200
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Qiang Zhao <qiang.zhao@nxp.com>
Cc:     broonie@kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: fsl-dspi: fix NULL pointer dereference
Message-ID: <20201029110319.iyvfmrlq6uz2pl2e@skbuf>
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

Please update your tree.
https://github.com/torvalds/linux/commit/6e3837668e00fb914ac2b43158ef51b027ec385c
