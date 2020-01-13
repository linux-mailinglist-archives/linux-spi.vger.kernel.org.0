Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B7DB13937B
	for <lists+linux-spi@lfdr.de>; Mon, 13 Jan 2020 15:17:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbgAMORm (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 13 Jan 2020 09:17:42 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46061 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726505AbgAMORl (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 13 Jan 2020 09:17:41 -0500
Received: by mail-pl1-f196.google.com with SMTP id b22so3866406pls.12;
        Mon, 13 Jan 2020 06:17:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=119x/Eo/ZhPiCKgs62+XdxHroV/8LTfvJfM2saKhvMM=;
        b=EpmaSjOrQz0+d6OkeqW0heot71A0xa5DkM5q720p+CpVjpinNi5eu32VBhrd+O34lQ
         eDAQz7/+a32YcaPqT9wIRP3A2pFR0c1Gl4JsduM49qY4JbHD32jeuCSH3OqK59mEVOms
         DHFe8PsooYXnKhrGxGQnqE8OhP2rhBv5NbrfdpRRGC9vbfv+q5vFfMYAabn2KfYeA4gK
         94SnJHIbEjbr2HIYR+Hr68pfBzBrAVYEhCWKuw3DEyijbjb1Sw7+jaLnLB2+hD3oVapk
         LlmfwTQtbzwUdOB3+ZLzl55wNOoZgI8t618Y7T5meC05opnGClv0Eyb2+ViO/n9v+Qp9
         SZ3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=119x/Eo/ZhPiCKgs62+XdxHroV/8LTfvJfM2saKhvMM=;
        b=dsUPNZBz6eJoEjFW+EwAy3rHqSy/qcOGkMqLdkwlQje2qIF+n95iLF4lXTr31Z58Su
         rlHUut6MjNAIWtXvJYSQC18ltpuy9u8xEEwzuC48fTNVVUi9ESQDuvl2l+0wXiuoyNhs
         W4dkvRPYyzG/CI2fa5sxXp2/ukwPtgUi9dNsOmMFjSkPav7n7jN6VGyEX4g4bgCHBnaq
         nhpbRXASTgAz5DYsZemvN/HxG6kK9NYds0HOaaOgBuuOa17ap34RqPM0IuBgP8Cajfrh
         +YqJlWJfZ3F0E4Y9ZE7NbLwVUzVc+PX75hFxtotV6kAShiitVHziO1hL3p3KcjiG/PEO
         zJZg==
X-Gm-Message-State: APjAAAWl2NLcytsXgtkBPj4LfWfESMgxDxZLETCSRiuSopbhNczM3ozf
        4vSCt9B92/ozHKZT83fgj6Da1ahXd7Seo7yWeaU=
X-Google-Smtp-Source: APXvYqy/D2U/FQw2fb9jrTRONhgmF8LX4dXqawk9ArLlxHsN/8v4y1E1uniZK1AjWAL142s551EWDJ4RvlQqLC5nESU=
X-Received: by 2002:a17:90b:3109:: with SMTP id gc9mr22592063pjb.30.1578925061030;
 Mon, 13 Jan 2020 06:17:41 -0800 (PST)
MIME-Version: 1.0
References: <1575900490-74467-3-git-send-email-john.garry@huawei.com>
 <0dc5cb2e-b765-9e13-b05e-9e3c835c5985@huawei.com> <20200109212842.GK3702@sirena.org.uk>
 <df67b562-7d82-19f6-7581-680190a7772d@huawei.com> <20200110140726.GB5889@sirena.org.uk>
 <6db83881-927c-d11c-9c77-23a45892ddab@huawei.com> <20200110193119.GI32742@smile.fi.intel.com>
 <612a3c5d-69a4-af6b-5c79-c3fb853193ab@huawei.com> <20200113114256.GH3897@sirena.org.uk>
 <6dd45da9-9ccf-45f7-ed12-8f1406a0a56b@huawei.com> <20200113140627.GJ3897@sirena.org.uk>
In-Reply-To: <20200113140627.GJ3897@sirena.org.uk>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 13 Jan 2020 16:17:32 +0200
Message-ID: <CAHp75VfepiiVFLLmCwdBS0Z6tmR+XKBaOLg1qPPuz1McLjS=4Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] spi: Add HiSilicon v3xx SPI NOR flash controller driver
To:     Mark Brown <broonie@kernel.org>
Cc:     John Garry <john.garry@huawei.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        tudor.ambarus@microchip.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        chenxiang66@hisilicon.com, Linuxarm <linuxarm@huawei.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        "open list:MEMORY TECHNOLOGY..." <linux-mtd@lists.infradead.org>,
        Jiancheng Xue <xuejiancheng@hisilicon.com>,
        fengsheng5@huawei.com,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        wanghuiqiang <wanghuiqiang@huawei.com>, liusimin4@huawei.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, Jan 13, 2020 at 4:07 PM Mark Brown <broonie@kernel.org> wrote:
> On Mon, Jan 13, 2020 at 01:01:06PM +0000, John Garry wrote:
> > On 13/01/2020 11:42, Mark Brown wrote:
>
> > > The idiomatic approach appears to be for individual board vendors
> > > to allocate IDs, you do end up with multiple IDs from multiple
> > > vendors for the same thing.
>
> > But I am not sure how appropriate that same approach would be for some 3rd
> > party memory part which we're simply wiring up on our board. Maybe it is.
>
> It seems to be quite common for Intel reference designs to assign
> Intel IDs to non-Intel parts on the board (which is where I
> became aware of this practice).

Basically vendor of component in question is responsible for ID, but
it seems they simple don't care.

-- 
With Best Regards,
Andy Shevchenko
