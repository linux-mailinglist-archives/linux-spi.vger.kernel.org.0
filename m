Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B0AC42AC81
	for <lists+linux-spi@lfdr.de>; Tue, 12 Oct 2021 20:52:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234289AbhJLSvt (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 12 Oct 2021 14:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235168AbhJLSvi (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 12 Oct 2021 14:51:38 -0400
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AFE2C06176A
        for <linux-spi@vger.kernel.org>; Tue, 12 Oct 2021 11:49:34 -0700 (PDT)
Received: by mail-ua1-x92b.google.com with SMTP id f4so538280uad.4
        for <linux-spi@vger.kernel.org>; Tue, 12 Oct 2021 11:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eclypsium.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4kUtfp3H5GSUAINL9ZlTXdmm6nQlA3alJD1HkhEN17Y=;
        b=BE9TkAn9CWkILNMSxRZNrL3BucUaTmKja+sHQ6rTl7VvCv7FS9cbOSYE6f3P7uSGcu
         yG39yakmvYSkDoQtQNnLcuHY6bX2aEDXsrW8GF4OeM7IIOdA2J3yPcEwM+zI143xNuTo
         kLeEYDFaWFLj4ujpxYnc9altRsZWN2EZDOXN0M2Fr7ZYEFbXOBUwthx7OBlnzG+9wcMV
         /wWj/AoS5nc7dxR2+3MbvGSwMeAhBxqlYV0T2g99TftJN30wXmLu8lzng2X1tSL2vYJQ
         bPmSGHIpR+zek9qqvXjeV5mZe3/wZFpACrCbEPKa55PznZa6KZFsaW1PiThR2fEOfbxc
         bYGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4kUtfp3H5GSUAINL9ZlTXdmm6nQlA3alJD1HkhEN17Y=;
        b=xaweYdINpNDdRaLOY87phg2OCQeBPHXzG3YbqOgMpoX1r5c76fQUnE2CVzaGEbNxBU
         /57ro+lR1dw5V+MUyoEFtE0EMVsif4ABukxsokXunBBkk0qpEHpqphCI1FkMPLg1jj26
         H2T19BKtEBgnxRJ4mD+V3ClD1xPyV5vt0lfueFKAYiW0AntIMDa9Lx3fM9N7hGh3jY5o
         63LgvIXB6+vQSTFNjA6IE5CHts+fPylNDuCedVi1JQ2j3waGIdB1jqKWyYSCXlEdawLY
         oRCPkJdFJeT5sL34Ddze/qIhWQ639sC2iTUukV4+4Ql7xfisoRziebNxscgw0NB2EUNe
         UBXA==
X-Gm-Message-State: AOAM532qvdXJXcUDMryY6BEHFAnJI2Z6mCDBvFYyoC33gXkFLFJ+Bm5/
        Zb86WhoDdIzTemcY3RgIJppqsZFcAhDMqeSMEJ9MHg==
X-Google-Smtp-Source: ABdhPJxP6PaDnpfe1GV2kJAHss8zrzOzBgcuTdv/5lJXJJnABkEoHAt2AvoHY8ikK5qYw27oeMpZvAAlX4n70PaT46c=
X-Received: by 2002:a67:f74f:: with SMTP id w15mr32770975vso.61.1634064573327;
 Tue, 12 Oct 2021 11:49:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210930100719.2176-1-mika.westerberg@linux.intel.com>
 <20210930100719.2176-2-mika.westerberg@linux.intel.com> <CAArk9MPWh4f1E=ecKBHy8PFzvU_y_ROgDyUU_O3ZQ0FuMhkj5Q@mail.gmail.com>
 <YVqOjF/xjqFV+Dl3@lahna>
In-Reply-To: <YVqOjF/xjqFV+Dl3@lahna>
From:   Mauro Lima <mauro.lima@eclypsium.com>
Date:   Tue, 12 Oct 2021 15:49:22 -0300
Message-ID: <CAArk9MPY+rCQse+JXtvb4KqunN9FZ=toK_v=PV-ro4cO6=5s7Q@mail.gmail.com>
Subject: Re: [PATCH 1/3] mtd: spi-nor: intel-spi: Disable write protection
 only if asked
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Mark Brown <broonie@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Michael Walle <michael@walle.cc>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Mika

On Mon, Oct 4, 2021 at 2:18 AM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> Hi,
>
> On Fri, Oct 01, 2021 at 05:23:23PM -0300, Mauro Lima wrote:
> > Question for maintainers: With these changes is it safe to remove the
> > *(DANGEROUS)* tag from menuconfig?
>
> I don't think we want to remove that. This driver is not for regular
> users, at least in its current form.
Do we know why this is still dangerous for the user?
My plan is to make a sys/class driver to query write protection status
of the SPI, this will be
used by fwupd to gather information about vendors, also should be easy
for the user to use
'cat' and see the information from userspace. For this to be possible
we need kernel engineers
to compile the kernel with this driver enabled, but the (DANGEROUS)
tag is a no go for most
of them.
Is there anything I can do to make this possible?
Thanks
