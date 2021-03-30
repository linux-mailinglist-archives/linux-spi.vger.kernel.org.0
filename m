Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB7D734E6F2
	for <lists+linux-spi@lfdr.de>; Tue, 30 Mar 2021 13:57:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231743AbhC3L5C (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 30 Mar 2021 07:57:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbhC3L4z (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 30 Mar 2021 07:56:55 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D850BC061574
        for <linux-spi@vger.kernel.org>; Tue, 30 Mar 2021 04:56:54 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id g8so23344050lfv.12
        for <linux-spi@vger.kernel.org>; Tue, 30 Mar 2021 04:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+Slicq9XZYmOYmxSP6NL63BvWaoWyxDuVadlbcrdQD8=;
        b=ZMALzz+lAq63BG4oQTKP5y8vKCL60oE0YPGRhNIX4Yp/R8gWVhM+E5iSRC5XW0tOvY
         GC+uf3hvaQOglAt1kmDJlLeqV8Fc3PXyCVqsW3+zBF2+/f9U3evkWxQvgyhyEYwlA0xM
         N28rZJpjORn2AyNQviP8qITM3SSWC1ixxq9pnFsrsBTW0kk2kwvvk+QknDbfHXq856Ts
         epng6i52YnMrWjUx3i5vDpffBsBKsA+whqVXjkziiOftaP5FVmDcvU30pFWcPxAdcphm
         /BCCai6d3FHROwLz9TUZSNAIctYI4LWWNnFEPqRY6w+7D9wOy6GDSD9oauk9X3ViIrk7
         eNuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+Slicq9XZYmOYmxSP6NL63BvWaoWyxDuVadlbcrdQD8=;
        b=gn5Qz4sTDiGHH6gBVuqTFgilw/Qp4DlaU7aIkye1BGFcgKo2aMNK4yDJmYki4DN/YE
         iXoancZfFLTxVaymhdtf0nA4WvBjPOdZjqEKs+tD+AatTdy91bKFKJOJtv7/7QMQoOPT
         ZVeFXOlKZCECG8tILzGtDwyw2fiLcAe1lHyA1lIuLPfFCQTUJvkU0MDYEr1YNo9ye6lB
         o6KdPELQ7eH9tbbh21CCDGknJ3YqUq5jRqkGC3i9Vi0EptlQq1e7KzShCULRctVJVfvl
         v8qyrqhygyA8oXXGFUiRgIZdMk4P47226uKYSob0RYpACaGD5ZlJzLx6MDSPpT55C3jt
         XIdQ==
X-Gm-Message-State: AOAM532GP4DRihTalJAQsNwnm+VhLmUx0ikK0mjAerDJ7PL9FOKbWa7L
        mT6oC+P5Eli1rNeLCtnpkuqTU3dCPIuwMifSo8M=
X-Google-Smtp-Source: ABdhPJxWi55o+YGbpGTLUyoSCWibhbtuuQF4NP1NjTVsG8xx8XbhboZl1XhIOrQQrwjeL7fHAF4w7X2JP9Rl0hGm58s=
X-Received: by 2002:ac2:520f:: with SMTP id a15mr18469821lfl.223.1617105413391;
 Tue, 30 Mar 2021 04:56:53 -0700 (PDT)
MIME-Version: 1.0
References: <1617008316-60426-1-git-send-email-tiantao6@hisilicon.com>
 <20210329152157.GB5166@sirena.org.uk> <67027863-b52d-ad32-6e17-af5c1d284216@huawei.com>
In-Reply-To: <67027863-b52d-ad32-6e17-af5c1d284216@huawei.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 30 Mar 2021 08:56:41 -0300
Message-ID: <CAOMZO5ArUtHLREuWqKxSrh-SzYtaduWg9gQZqTFjXj9uEkzn9g@mail.gmail.com>
Subject: Re: [PATCH] spi: davinci: Use of_device_get_match_data() helper
To:     "tiantao (H)" <tiantao6@huawei.com>
Cc:     Mark Brown <broonie@kernel.org>, Tian Tao <tiantao6@hisilicon.com>,
        linux-spi <linux-spi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, Mar 29, 2021 at 9:54 PM tiantao (H) <tiantao6@huawei.com> wrote:

> Even with of_match_device, there is still a type conversion=EF=BC=8Cas fo=
llows
>
> spi_data =3D (struct davinci_spi_of_data *)match->data;
>
> Using of_device_get_match_data instead of of_match_device doesn't look
> like a problem from the code, other spi drivers do the same thing

What about doing it like this?

--- a/drivers/spi/spi-davinci.c
+++ b/drivers/spi/spi-davinci.c
@@ -817,18 +817,13 @@ static int spi_davinci_get_pdata(struct
platform_device *pdev,
                        struct davinci_spi *dspi)
 {
        struct device_node *node =3D pdev->dev.of_node;
-       struct davinci_spi_of_data *spi_data;
+       const struct davinci_spi_of_data *spi_data;
        struct davinci_spi_platform_data *pdata;
        unsigned int num_cs, intr_line =3D 0;
-       const struct of_device_id *match;

        pdata =3D &dspi->pdata;

-       match =3D of_match_device(davinci_spi_of_match, &pdev->dev);
-       if (!match)
-               return -ENODEV;
-
-       spi_data =3D (struct davinci_spi_of_data *)match->data;
+       spi_data =3D device_get_match_data(&pdev->dev);

        pdata->version =3D spi_data->version;
        pdata->prescaler_limit =3D spi_data->prescaler_limit;
