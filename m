Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9635549C30
	for <lists+linux-spi@lfdr.de>; Tue, 18 Jun 2019 10:40:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726091AbfFRIk7 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 18 Jun 2019 04:40:59 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:42884 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbfFRIk7 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 18 Jun 2019 04:40:59 -0400
Received: by mail-ot1-f67.google.com with SMTP id l15so3559143otn.9;
        Tue, 18 Jun 2019 01:40:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=10IeNowX3RW92UWladQLU7AhfNf5XVgPFvZ0Azmp+VA=;
        b=spmP1yx4Enan68cGYYcYM+py9PB+2pagjyUFfQ55L+jWv09pG8lxpQIoRECfVnJloo
         m4SytzTVh70lGwfIhCbQ8Bjhpf9Pyk0NpY5HGb+2ghECa0SZuxRiwz2fGuqfWwh2f7cJ
         OSTSN19kqfzN4xUfF3u4S0RAj7NUtAHWqKHRAM3QgRlR3mgsEpDIDU+mf7K0TLYBMdnd
         JM7JGkFQv3iRXxep6myG706XNg95z6OQ9+XT/5ABnPsOOgBJrmwMo1k8EfETNCM33ZP4
         OzcrovLx1z3dNyNbXmvnAL5ZX8RwuUWQjyDlC5cZ59jv9A/+rocSvbiCNehf+oP8RqdO
         rN5Q==
X-Gm-Message-State: APjAAAWHbvUFrZCarvvVJnUOlbF7w1TDNKW2KKTUCBykd0ysTMF/BKRg
        jRwPeVWFrgcMsK1nZkG9DrAnSM/i2oOGsAew3NI=
X-Google-Smtp-Source: APXvYqzBVXcfP7421rR8eXKYNY60z485ksnyrEI6OHcVnL1LP/bfIxHUVleiZmesIilT4xH9Q19toeV6i3LPcS7zT9U=
X-Received: by 2002:a9d:6a4b:: with SMTP id h11mr2146423otn.266.1560847258138;
 Tue, 18 Jun 2019 01:40:58 -0700 (PDT)
MIME-Version: 1.0
References: <1560534863-15115-1-git-send-email-suzuki.poulose@arm.com>
 <1560534863-15115-10-git-send-email-suzuki.poulose@arm.com>
 <CAJZ5v0gi2vpr5y3USnPnPBHjPA1YAwfqjsJppfLgBP5CcycGog@mail.gmail.com> <85f942fc-52fd-c4ed-29b3-f28c55a6a7bb@arm.com>
In-Reply-To: <85f942fc-52fd-c4ed-29b3-f28c55a6a7bb@arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 18 Jun 2019 10:40:47 +0200
Message-ID: <CAJZ5v0io59U1yy4RnX0fSXFyQ-PSHb1wXjLp7XLi8SzO3hSdVA@mail.gmail.com>
Subject: Re: [PATCH v2 09/28] drivers: Add generic match helper by
 ACPI_COMPANION device
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

On Tue, Jun 18, 2019 at 10:38 AM Suzuki K Poulose
<suzuki.poulose@arm.com> wrote:
>
> Hi Rafael,
>
> On 17/06/2019 23:07, Rafael J. Wysocki wrote:
> > On Fri, Jun 14, 2019 at 7:55 PM Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
> >>
> >> Add a generic helper to match a device by the ACPI_COMPANION device.
> >> This will be later used for providing wrappers for
> >> (bus/class/driver)_find_device().
> >>
> >> Cc: Len Brown <lenb@kernel.org>
> >> Cc: linux-acpi@vger.kernel.org
> >> Cc: linux-spi@vger.kernel.org
> >> Cc: Mark Brown <broonie@kernel.org>
> >> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> >> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> >
> > Please fold this change into the patch adding users of device_match_acpi_dev().
>
> There are variants of this by class/bus/driver and all of them are introduced
> as separate patches with the respective users. If we do for this, we have to
> do the same for other matches as well.
>
> i.e, [ device_match_by_attr + class_find_device_by_attr & users +
> driver_find_device_by_attr & users + bus_find_device_by_attr & users ]
>
> And that becomes a large chunk, which could make the review painful.
>
> If you would still like that approach, I could do that in the next revision.

Yes, please.
