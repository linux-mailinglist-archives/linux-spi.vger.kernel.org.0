Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE9F83710C
	for <lists+linux-spi@lfdr.de>; Thu,  6 Jun 2019 11:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727862AbfFFJ5q (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 6 Jun 2019 05:57:46 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:41783 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727846AbfFFJ5p (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 6 Jun 2019 05:57:45 -0400
Received: by mail-ot1-f66.google.com with SMTP id 107so1370732otj.8;
        Thu, 06 Jun 2019 02:57:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XH+qyuLG3h1Zuv0+YbIDecMVGDK3Yf4lc2GyNXDmgCk=;
        b=G7VrrbtpCxh/rN1JAhQrEvmREQYuCw3NR5KRlDQ7GRse0x1joem1ncsm764VVo2r9h
         IwVIWi9AOseuQ5tqTkH0G4nQGZsolIMHZhW07QsrZjWsKaUi7/2L71LXExdv5XrWFyv8
         VboxH9tM9U3k85DA8puxNAm85EaOUGbGLEQ+KoTLjuIhznA7uvC2WLyfEVPXgTnvAyPV
         1duwsDrhlMYcXpmOhPoTifhX/L5JpOXVEOCyW0/D0ouXj4Xhn4iFRz4t6M4Wubautshl
         aK82DCBJu/juTLxMdKKzxcWX9CgnbAcu41Ak6Qlp5Uk5inI8ZBJrK7ehwBvzLpsPcxym
         r7Cw==
X-Gm-Message-State: APjAAAWBWgKpnAbfrJ3xvUFEt2fDCCI/dTA/MzDKLHhtKzBe3pVYSGXh
        DwrB1OfLeZIWU2H3FMRNCK5HyXc6JmipdmBIbQI=
X-Google-Smtp-Source: APXvYqy5nqB0n3eU73l8b059KjjRZ1IWKzGCTX8XEy5gMjkUWBhjcYRq934pC1uevpc9TibD4eCiQLkvJ8Ih4I4t1Ik=
X-Received: by 2002:a9d:6b98:: with SMTP id b24mr13628927otq.189.1559815065036;
 Thu, 06 Jun 2019 02:57:45 -0700 (PDT)
MIME-Version: 1.0
References: <1559747630-28065-1-git-send-email-suzuki.poulose@arm.com>
 <1559747630-28065-8-git-send-email-suzuki.poulose@arm.com>
 <CAJZ5v0h+maPj-ijKV_vvQBpHD7N-VMiAqSeyztAkiUR9E2WdmQ@mail.gmail.com> <1f230eb7-f4e3-ed4e-960d-c3bbb60f0a18@arm.com>
In-Reply-To: <1f230eb7-f4e3-ed4e-960d-c3bbb60f0a18@arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 6 Jun 2019 11:57:33 +0200
Message-ID: <CAJZ5v0i0WP88+vTEheSTfAoSi5nEdjaLs4KOGxXK3_AoPhPrhg@mail.gmail.com>
Subject: Re: [PATCH 07/13] drivers: Add generic match helper by ACPI_COMPANION device
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, Jun 6, 2019 at 11:28 AM Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>
>
>
> On 06/06/2019 10:17, Rafael J. Wysocki wrote:
> > On Wed, Jun 5, 2019 at 5:14 PM Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
> >>
> >> Add a generic helper to match a device by the acpi device.
> >
> > "by its ACPI companion device object", please.
>
> Sure.
>
> >
> > Also, it would be good to combine this patch with the patch(es) that
> > cause device_match_acpi_dev() to be actually used.
> >
> > Helpers without any users are arguably not useful.
>
> Sure, the helpers will be part of the part2 of the whole series,
> which will actually have the individual subsystems consuming the
> new helpers. For your reference, it is available here :
>
> http://linux-arm.org/git?p=linux-skp.git;a=shortlog;h=refs/heads/driver-cleanup/v2
>
> e.g:
> http://linux-arm.org/git?p=linux-skp.git;a=commit;h=59534e843e2f214f1f29659993f6e423bef16b28
>
> I could simply pull those patches into this part, if you prefer that.

Not really.

I'd rather do it the other way around: push the introduction of the
helpers to part 2.

> However, that would be true for the other patches in the part2.
> I am open to suggestions, on how to split the series.

You can introduce each helper along with its users in one patch.

This way the total number of patches will be reduced and they will be
easier to review IMO.
