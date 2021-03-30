Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA35C34E74C
	for <lists+linux-spi@lfdr.de>; Tue, 30 Mar 2021 14:16:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231991AbhC3MP7 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 30 Mar 2021 08:15:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231934AbhC3MPq (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 30 Mar 2021 08:15:46 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F84EC061574
        for <linux-spi@vger.kernel.org>; Tue, 30 Mar 2021 05:15:46 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id m12so23419596lfq.10
        for <linux-spi@vger.kernel.org>; Tue, 30 Mar 2021 05:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fO0dzoju+AAyoCE28d9zsSmQ2TeXPUGX8JLFnIeFhlU=;
        b=ULe9Ax/LL7x1vw+gAkKJK9gfYkdgRjXQSYiAfakcAAzi17BigvcU6UCD3q4uSjEYC/
         3JJPH77u4zDRmiDQXDWrb/ZT1kqKhGmt/K94LpOE6C5mvA9EkL84NGrWqAk2l9GOYTLw
         pwgKHb2a+HnCTArqI8oNfKOYPeS81udh7uOEjLXf0trFgbDNSkGlCRqqWcYQxyVBsLFx
         tY0DrK3+jGq4t0iHEIRgi2rueO9ifs0ZI3D+ntfZDf2uD6XRyjpWS4r60uNaL4q4a7hz
         fv4VFeI/nWn6G+mY5b7POalzHYP19NV9Epnqx4DlwrbnLHkFHJW01VLBfSRh/jUF819N
         keoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fO0dzoju+AAyoCE28d9zsSmQ2TeXPUGX8JLFnIeFhlU=;
        b=Ie/yoBa1PQuG9p+RuLPGTU6TjOI9AJq9vV7RS2STj2jELOC+g9tRlNgXvjk68EJ+SW
         6dIf2KXYyvi1huP+B8lJAPrwpS32vs0JORIUT1+YaTutZXKCdokwGIL3HFYOgWp6XloZ
         /fgkRLEHX9gLW3Y3HRTEcrPWF3eXGLYmE390w+qldHiuWXGov356/mYdj0bJcbhSF2tA
         r0osZnb/5ewiEU4L+lfxrZN99mgwpzsCVjhXfig/TmL0ZoNnIQfHH1utMFHA/spL1vSp
         AVzYr79AkZ8aLBKhgS1zF85CeSigTsqaOVcDAydwABkiJ2prhVKVvXnZ1S8eYZMhEk6g
         FAOA==
X-Gm-Message-State: AOAM530snr89KI6R7IbZLVL7Sn6sIGFKv88DFTTFZnSWZhWOWxnKsyhP
        oQBSk2u39/Vcm7lr/sODIPK4rM/JUdzqAG2ZXYQ=
X-Google-Smtp-Source: ABdhPJw13dwa+fhx/0VhsbqVduzM6Qwy4MUU4x+SsxM4EfPAVUayAUbuBlTW07i+2k/NT2gI1S9TBGY/RiAhIhLIibs=
X-Received: by 2002:a05:6512:1031:: with SMTP id r17mr19151030lfr.583.1617106544982;
 Tue, 30 Mar 2021 05:15:44 -0700 (PDT)
MIME-Version: 1.0
References: <1617008316-60426-1-git-send-email-tiantao6@hisilicon.com>
 <20210329152157.GB5166@sirena.org.uk> <67027863-b52d-ad32-6e17-af5c1d284216@huawei.com>
 <CAOMZO5ArUtHLREuWqKxSrh-SzYtaduWg9gQZqTFjXj9uEkzn9g@mail.gmail.com> <bc792674-dca3-8fd7-dc55-3fceb1de4524@huawei.com>
In-Reply-To: <bc792674-dca3-8fd7-dc55-3fceb1de4524@huawei.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 30 Mar 2021 09:15:33 -0300
Message-ID: <CAOMZO5Ad5L-y9YTiOantOWow_CPaeGnNMjf8hM_-eH4ShMQS7A@mail.gmail.com>
Subject: Re: [PATCH] spi: davinci: Use of_device_get_match_data() helper
To:     "tiantao (H)" <tiantao6@huawei.com>
Cc:     Mark Brown <broonie@kernel.org>, Tian Tao <tiantao6@hisilicon.com>,
        linux-spi <linux-spi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, Mar 30, 2021 at 9:12 AM tiantao (H) <tiantao6@huawei.com> wrote:

>  From what I have tested, the results are ok. I will send v2 to fix.
>
> make modules M=3Ddrivers/spi/
>    CC [M]  drivers/spi//spi-davinci.o
> drivers/spi//spi-davinci.c: In function =E2=80=98spi_davinci_get_pdata=E2=
=80=99:
> drivers/spi//spi-davinci.c:826:11: warning: assignment discards =E2=80=98=
const=E2=80=99
> qualifier from pointer target type [-Wdiscarded-qualifiers]
>    826 |  spi_data =3D of_device_get_match_data(&pdev->dev);

This warning does not appear if you apply the patch I suggested.
