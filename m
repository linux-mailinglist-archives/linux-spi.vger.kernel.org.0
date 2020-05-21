Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAA2E1DC839
	for <lists+linux-spi@lfdr.de>; Thu, 21 May 2020 10:06:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728436AbgEUIGr (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 21 May 2020 04:06:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726208AbgEUIGr (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 21 May 2020 04:06:47 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1ECDC061A0E;
        Thu, 21 May 2020 01:06:46 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id s10so2838547pgm.0;
        Thu, 21 May 2020 01:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k40fNAPXoqmQP1FhrrcCGnUWipnxFvRD1OtdKcLVzYc=;
        b=A6J1wahzIxjtEb2O83TdcYZ7U0m/K82Pkm+nWBGuEea3ysgqVMdBEG5F1q8TE/ZDlO
         tMHcaDzDKJG5Z/AFU1Oc4YPbzGbb49fKUw/YgoCrnDXyADEx2WlbO4I5WSDj+JTbVqE+
         OasbcOql7U0W996Z+GG6HYf1pCcuiJaOHgDSO5ExKwal316rtCM6IGhS+qnHyhqw7n/p
         T7AwmLi2ub9nrFJhqWitgRspP7+/U1CmpEfmM1Vhn7Mi+sNYeK7IBJW9oxXt/s1O0g2O
         puiRXex4Bgc5Dz/GP6qhq2SRj6+dXBxL856i7tftVtIsxAtJDTwZbyZgiZyJpkQwqK6d
         quTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k40fNAPXoqmQP1FhrrcCGnUWipnxFvRD1OtdKcLVzYc=;
        b=ewXo0i7DyB/TzZdHu//hUnvPj7n/enBZAPbHnm2mXCvYkFJoTvzDHKRuCWH32fOaQK
         jFL/s9Y2BZz671h3OCLfKQ0UACvjT7mOMdDJQx9fjejU05e+Igotwe0lPLUtJ1aLNCcV
         CwVC9q4iWFFhMTCgWLg6tu1d4qaKXFBkjjSjcuA3V2Rg+WnqgmYbOp0QPuZNOy67ct+C
         4VCM2rgc1gJY+04QXiyzdBy/jY9bkOscB7KOC3bYZI0AbY2+88K/zpXblzRP/jFuRY7C
         H+fZ7bg223PBTZVkeGfhtrfPs/Yz4G1dV/lr3Pyw5wok4Hl5NBRULCH3XoXQXTR66vKV
         7tZg==
X-Gm-Message-State: AOAM532oxU5WMzyOUqrNUD7YLLLOSBGLtReG4DVBPOjnoHCTmX+2Vygn
        5fG7lk5s7PV/jPdcPJoPjFJuFlDvH9ZdZiFm00AE+46TbCr//w==
X-Google-Smtp-Source: ABdhPJx9p94gFwsPw8gWADP5SmoZj9B/VTNWMcaLJkza3Q0EMpaIbQ45SU9mjxl0uKnNrivAJZ/MKRXndqVU3J3Z9nM=
X-Received: by 2002:a65:6251:: with SMTP id q17mr7637382pgv.4.1590048406263;
 Thu, 21 May 2020 01:06:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200521074946.21799-1-dinghao.liu@zju.edu.cn> <CAHp75VfOeUaqRW2vRwyWaz3JJw41hX5jTgE+kZ8pB8E_HtHwqw@mail.gmail.com>
In-Reply-To: <CAHp75VfOeUaqRW2vRwyWaz3JJw41hX5jTgE+kZ8pB8E_HtHwqw@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 21 May 2020 11:06:30 +0300
Message-ID: <CAHp75Vf=a54jY+5ZoWG9Fkjf-0-TQWqNY6R4sPM7Y2oTyCNL6A@mail.gmail.com>
Subject: Re: [PATCH] spi: tegra20-slink: Fix runtime PM imbalance on error
To:     Dinghao Liu <dinghao.liu@zju.edu.cn>
Cc:     Kangjie Lu <kjlu@umn.edu>, Laxman Dewangan <ldewangan@nvidia.com>,
        Mark Brown <broonie@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        linux-tegra@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, May 21, 2020 at 11:04 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Thu, May 21, 2020 at 10:50 AM Dinghao Liu <dinghao.liu@zju.edu.cn> wrote:

Any I have coccinelle script for this, I can share with you.

-- 
With Best Regards,
Andy Shevchenko
