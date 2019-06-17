Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F38D5494C1
	for <lists+linux-spi@lfdr.de>; Tue, 18 Jun 2019 00:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727145AbfFQWH1 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 17 Jun 2019 18:07:27 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:35346 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726776AbfFQWH0 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 17 Jun 2019 18:07:26 -0400
Received: by mail-ot1-f66.google.com with SMTP id j19so11435031otq.2;
        Mon, 17 Jun 2019 15:07:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AFy/9cysAawEQrUMoAZ4MyvgzzTIR1Smv13PGFCI2ms=;
        b=l/XIcDHbRwEpxuyjOww9TbgMveWUlyYSoDZjOunrq6gvYP5bC4mBJFYQvHXsd9w6rp
         nOFr9RC+hROuQqfnfRfDbz4dckMkVV51x8zR5oxCIL+m1m6D8QLEJUNnLL9eazFFQn71
         AWyw2V4Ay8FdrILGZHV125YM7ldUX+Cf1f+C+LudC+DSeCgnl3uqJd29wbNwv2DgX3DD
         xOeLkNRjiPDLLQyROkeIypuyVB40FpGHjZXqaqmHLU5/C1uERq4H5u7eAsM82uFo0ui3
         3S8SeVdqO5Uwi8NQ7LkJZnLEwKIb2cgAm3S3ho8DKHc+Qhq1CDKjVQNY8SARmhGFuxx6
         NeNg==
X-Gm-Message-State: APjAAAWjS8S7Fz8nk1R/D6PpIYpZGwHAOMmH6IqOnN23lfxjlXOmLrfR
        gcbTlqLfgG7WtOVkvxoIKcq6Q8mr41J8G+3eyM0=
X-Google-Smtp-Source: APXvYqwTNmgy24pYXwR4INVjV8iW1gliaNLtQySRakOJo1leZBtxgEns5qtz2Uj8iNgMTwmNYfc9rTjq9qe9/cnFUNE=
X-Received: by 2002:a9d:5e99:: with SMTP id f25mr32693430otl.262.1560809246008;
 Mon, 17 Jun 2019 15:07:26 -0700 (PDT)
MIME-Version: 1.0
References: <1560534863-15115-1-git-send-email-suzuki.poulose@arm.com> <1560534863-15115-10-git-send-email-suzuki.poulose@arm.com>
In-Reply-To: <1560534863-15115-10-git-send-email-suzuki.poulose@arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 18 Jun 2019 00:07:14 +0200
Message-ID: <CAJZ5v0gi2vpr5y3USnPnPBHjPA1YAwfqjsJppfLgBP5CcycGog@mail.gmail.com>
Subject: Re: [PATCH v2 09/28] drivers: Add generic match helper by
 ACPI_COMPANION device
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

On Fri, Jun 14, 2019 at 7:55 PM Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>
> Add a generic helper to match a device by the ACPI_COMPANION device.
> This will be later used for providing wrappers for
> (bus/class/driver)_find_device().
>
> Cc: Len Brown <lenb@kernel.org>
> Cc: linux-acpi@vger.kernel.org
> Cc: linux-spi@vger.kernel.org
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>

Please fold this change into the patch adding users of device_match_acpi_dev().

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
