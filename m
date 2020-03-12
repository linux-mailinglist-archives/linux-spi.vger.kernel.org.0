Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45EEC182FFE
	for <lists+linux-spi@lfdr.de>; Thu, 12 Mar 2020 13:12:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726044AbgCLML7 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 12 Mar 2020 08:11:59 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:36852 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbgCLML7 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 12 Mar 2020 08:11:59 -0400
Received: by mail-lf1-f66.google.com with SMTP id s1so4604219lfd.3;
        Thu, 12 Mar 2020 05:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bhPuS2kHLGbKBKVVwz2ohfgffpqHWog6BAcU5D3FSBE=;
        b=l5d2Kt8D9rVBConO0hJsQfXbHz5ahmwaLbLGDdsUHuKeYlfAKOonlz5/pyu4KsWiAU
         Edz+T8DmoWjOzy7JVyOH7t65Z6nhA4PdGGEUrXIDBPEE9PG0+ht7rXbNOjY3/XxoHPEo
         16uxDrS06mLHiiAMDwvTocwdQbczU+EtAAemu25GeFZWFLYfgLPxxgaQp2/pEAv7aYOq
         CZ9++NtuxXYU9IoYo76er/KJAFrF0EX6z0kYusW8L5k9TYNUwDY+mcKpBZK1nx7bPL38
         j1R506wpFxZu7cS5/KV+OMHxPJd9BSa6kTTRz6cmBkZEAXeftYrgfynGmL79ZDi9VLD1
         hXyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bhPuS2kHLGbKBKVVwz2ohfgffpqHWog6BAcU5D3FSBE=;
        b=jJ7pHbm+bcnYq7Fs/aWQMAOS+adcbfELCuKMvfDbUJuE8X7CrOeNIK4LTgg21naPq9
         DZtK/vHJCCX2pMNj+KXLtXGrX0CGu3qCA12cD/qcqKryZ8LUrVuRDSdbSpHxDbdmn9Ms
         AzWJMOL3pIvvbG+3cEz2BddnaArqNVQJoE5eJ5A1GEEycekV5WmiqgjejW/qhlLjo6bN
         eWqvAijNBrij1tKEMhS9HvAOfLOLXi2FnF4ZDDl2R02XgUg6v+e1PuGoytTZnxLVQHGt
         +eBaYx8c5+ON4qey+EpAud4qklVNx7ljPA0iodBvcEO4lCI3fDe5qalv+5nczr/TTPFk
         /zCA==
X-Gm-Message-State: ANhLgQ17RAa3giWqj60aKA68aZiOjEIijV1ZI1yr7VpiKKR8102wGz/5
        1w60MXWRWD9pOkxhD30beWZanAYQNTJ7ifwiBpo=
X-Google-Smtp-Source: ADFU+vt+smGa5nmX26aTHJS4CvOUbbW1B0u85c531RF3WHPuD82m2io3CGiJr/IWQLQ5O69ZiTCpC6d4x2B89Zutzl8=
X-Received: by 2002:ac2:5929:: with SMTP id v9mr5073525lfi.66.1584015115914;
 Thu, 12 Mar 2020 05:11:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200312113154.GC20562@mwanda>
In-Reply-To: <20200312113154.GC20562@mwanda>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 12 Mar 2020 09:11:44 -0300
Message-ID: <CAOMZO5CJ7G7yJZEEPfsm1P2SnrJ7kmOPmZCWiKwrvDZjPNOnWw@mail.gmail.com>
Subject: Re: [PATCH] spi: spi-nxp-fspi: Fix a NULL vs IS_ERR() check in probe
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Yogesh Gaur <yogeshgaur.83@gmail.com>, Han Xu <han.xu@nxp.com>,
        Adam Ford <aford173@gmail.com>,
        Ashish Kumar <ashish.kumar@nxp.com>,
        Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Dan,

On Thu, Mar 12, 2020 at 8:33 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> The platform_get_resource_byname() function returns NULL on error, it
> doesn't return error pointers.
>
> Fixes: d166a73503ef ("spi: fspi: dynamically alloc AHB memory")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
> The commit message for commit d166a73503ef ("spi: fspi: dynamically
> alloc AHB memory") is not very good.  Why is it necessary to allocate
> the AHB memory dynamically instead of during probe?  Also I suspect that

Agreed and I made the same comment during review:
https://patchwork.kernel.org/patch/11361581/

Thanks
