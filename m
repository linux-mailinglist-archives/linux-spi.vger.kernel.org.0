Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 517B536FAA
	for <lists+linux-spi@lfdr.de>; Thu,  6 Jun 2019 11:17:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727664AbfFFJRx (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 6 Jun 2019 05:17:53 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:38168 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727540AbfFFJRx (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 6 Jun 2019 05:17:53 -0400
Received: by mail-ot1-f68.google.com with SMTP id d17so1295315oth.5;
        Thu, 06 Jun 2019 02:17:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yENjbVk39/wwzHKltPutprMF9DY/I7doCf7SfJRKgi8=;
        b=It0+PNjNfu9hf2ysUWEID6Ddo/m/1ROgFUoYE1BzrlLq1DJ5ICLUptAs/Pvj/erwj+
         UqPr/gflG5rGdX7/0PPxU2RFl1kwNKHDppX43EErtLJR+qVApumfyK/udXI3KAejv1TW
         8C0nI32rC54+RrXSCPswTrHerCC2U/nxouNXmtaekQpDOqNfQZI3aHpdAYlTgwBYaXzH
         8AoEaxdW5Ahpgl//1QP0UsZ2ErEf0QqVejAl4bbzUxGZA68TvulAPqvnJ4uHUHeaM1Ur
         TqoT3tevRVuMPx9VPnuDnwgy4OX5itVymAiFKe3i/m22zfoon8vWi0ZPphDO0LHq0H4N
         dqOQ==
X-Gm-Message-State: APjAAAUSvZfFIX3ZzKGjUi8A+mKzOUI+WVogM3tf8JjbojLj+lOoNmWV
        16qm9v0ICsVT54R+gBWM0mdYtVpOf4o9ZlO/BCs=
X-Google-Smtp-Source: APXvYqwpqt4Y2D/ykZ/hJu7b0Xpsn+y8x9Q8fDqgKz20jFQNzEUdq+RPWEe2mZF6bzoomXq7tP+vR0+dQ/lk+sV4jGk=
X-Received: by 2002:a05:6830:150:: with SMTP id j16mr14282814otp.262.1559812672475;
 Thu, 06 Jun 2019 02:17:52 -0700 (PDT)
MIME-Version: 1.0
References: <1559747630-28065-1-git-send-email-suzuki.poulose@arm.com> <1559747630-28065-8-git-send-email-suzuki.poulose@arm.com>
In-Reply-To: <1559747630-28065-8-git-send-email-suzuki.poulose@arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 6 Jun 2019 11:17:41 +0200
Message-ID: <CAJZ5v0h+maPj-ijKV_vvQBpHD7N-VMiAqSeyztAkiUR9E2WdmQ@mail.gmail.com>
Subject: Re: [PATCH 07/13] drivers: Add generic match helper by ACPI_COMPANION device
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, Jun 5, 2019 at 5:14 PM Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>
> Add a generic helper to match a device by the acpi device.

"by its ACPI companion device object", please.

Also, it would be good to combine this patch with the patch(es) that
cause device_match_acpi_dev() to be actually used.

Helpers without any users are arguably not useful.

>
> Cc: Len Brown <lenb@kernel.org>
> Cc: linux-acpi@vger.kernel.org
> Cc: linux-spi@vger.kernel.org
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  drivers/base/core.c    | 6 ++++++
>  include/linux/device.h | 1 +
>  2 files changed, 7 insertions(+)
>
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index b827ca1..597095b 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -3346,3 +3346,9 @@ int device_match_devt(struct device *dev, const void *pdevt)
>         return dev->devt == *(dev_t *)pdevt;
>  }
>  EXPORT_SYMBOL_GPL(device_match_devt);
> +
> +int device_match_acpi_dev(struct device *dev, const void *adev)
> +{
> +       return ACPI_COMPANION(dev) == adev;
> +}
> +EXPORT_SYMBOL(device_match_acpi_dev);
> diff --git a/include/linux/device.h b/include/linux/device.h
> index f315692..a03b50d 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -166,6 +166,7 @@ void subsys_dev_iter_exit(struct subsys_dev_iter *iter);
>  int device_match_of_node(struct device *dev, const void *np);
>  int device_match_fwnode(struct device *dev, const void *fwnode);
>  int device_match_devt(struct device *dev, const void *pdevt);
> +int device_match_acpi_dev(struct device *dev, const void *adev);
>
>  int bus_for_each_dev(struct bus_type *bus, struct device *start, void *data,
>                      int (*fn)(struct device *dev, void *data));
> --
> 2.7.4
>
