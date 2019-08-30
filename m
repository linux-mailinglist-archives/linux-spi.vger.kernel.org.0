Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97883A2E9A
	for <lists+linux-spi@lfdr.de>; Fri, 30 Aug 2019 06:36:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbfH3Egi (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 30 Aug 2019 00:36:38 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:37897 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725648AbfH3Ege (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 30 Aug 2019 00:36:34 -0400
Received: by mail-lj1-f195.google.com with SMTP id x3so5170492lji.5
        for <linux-spi@vger.kernel.org>; Thu, 29 Aug 2019 21:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pB+rGb0tWqsHi1eIDIKoLqLIFW12dRXmfWgM+te26nw=;
        b=ALInY0Cuh6sE9r14N2IRVle5WxABFqoqToXOgwRGgsjOcKV9iCprY1zwD8lAAxu0Zo
         iOK7DFOkXPvHfFzJmhm9G6YDncNSgtjCFXjAvEmxbvbZPT0MW7lazGTy29LAg290UvSP
         MlUlLBl6no5f/mWsgwMcDHcS0EGQNzyUBrziA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pB+rGb0tWqsHi1eIDIKoLqLIFW12dRXmfWgM+te26nw=;
        b=IJ6NIow+/HSlJosnVrzrOHZO83WsCaH+0KsPFqGr3uoe083jGpOTzbSX4ggk+N/h/a
         bJcxWDNpRfJMLTIiqgKFBR1a8bMHUrx2/RksZPa7ECVxljIK2qpkCNSE9I2ib3Y+3lDz
         p16ddMDrUkwVa6lLl2PZQjC8Z29Jefz/cq24vMqF0Y+c3X5sATjM1xGsBjJHSjKumePP
         oFbY6TEty1zNMQ/EY33EUaXCpYFbYdSvYM77925lf7RKG0Gao7ghxlR6vydPMd1dpNlv
         Q5Jkei1BJzfVUPTvVY7Zc+nEyv6L4MiOxtz7ZudHPWOSLmNdrA2WiK3XkTgGP9Y9WvNt
         4R3A==
X-Gm-Message-State: APjAAAWWVDzDeEFlzawtr/y/I7LubB+vPnNP5UFHmTxQJMGiXT8SoueF
        yFINpYyzFYiwAqQBp1/lWVDW9S1tGEIUfDKjO1qnmuCzObk=
X-Google-Smtp-Source: APXvYqwBfehU7rkS2AIu4PFjA/1cfoTtyS5T5ZZilgxRzlBBqm02HIlVTCKIxRfILwMZrrJM2pFl66UjPKKhl0Hlmkk=
X-Received: by 2002:a05:651c:104a:: with SMTP id x10mr7062558ljm.238.1567139792623;
 Thu, 29 Aug 2019 21:36:32 -0700 (PDT)
MIME-Version: 1.0
References: <1567052173-10256-1-git-send-email-rayagonda.kokatanur@broadcom.com>
 <20190829095907.GB4118@sirena.co.uk>
In-Reply-To: <20190829095907.GB4118@sirena.co.uk>
From:   Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Date:   Fri, 30 Aug 2019 10:06:21 +0530
Message-ID: <CAHO=5PG_rtONCLgOJCvUX7B=DENhow627xwXr3cQX_oOgmMmMw@mail.gmail.com>
Subject: Re: [PATCH V2 1/1] spi: bcm-qspi: Make BSPI default mode
To:     Mark Brown <broonie@kernel.org>
Cc:     Kamal Dasu <kdasu.kdev@gmail.com>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, Aug 29, 2019 at 3:29 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Thu, Aug 29, 2019 at 09:46:13AM +0530, Rayagonda Kokatanur wrote:
> > The spi-nor controller defaults to BSPI mode, hence switch back
> > to its default mode after MSPI operations (write or erase)
> > are completed.
> >
> > Changes from V1:
> >  - Address code review comment from Mark Brown.
>
> As covered in submitting-patches.rst inter-version changelogs should go
> after the --- so they don't end up in git.

Thank you, I fixed it and sent patch v3 for review.
