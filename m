Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAAB01FFBF7
	for <lists+linux-spi@lfdr.de>; Thu, 18 Jun 2020 21:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728909AbgFRTql (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 18 Jun 2020 15:46:41 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:31947 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728069AbgFRTql (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 18 Jun 2020 15:46:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592509599;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vAJJkV1IQ09o/T5NpQxIqWNeq9rz8g5RYhknLPVSVoA=;
        b=fYzn15gZgRg8nB8jQUpnTa2fUOiBfOX52xDdzx/9HEMX7y7O3UBlbXNTvtvDjOH0Q6RJei
        SRK19wvJ91531whOPxyALb30RVnIKG7ip0VnjjmvrtksvUqk0zkzH9yKXhMwpK9dF9bV2P
        GTqIZ98iB5PHd3wZHrwtPpBUBOJ+sIA=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-10-7tD5uc_qOUeMbPlvi8mDzw-1; Thu, 18 Jun 2020 15:46:38 -0400
X-MC-Unique: 7tD5uc_qOUeMbPlvi8mDzw-1
Received: by mail-qv1-f69.google.com with SMTP id o1so4883187qvq.14
        for <linux-spi@vger.kernel.org>; Thu, 18 Jun 2020 12:46:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=vAJJkV1IQ09o/T5NpQxIqWNeq9rz8g5RYhknLPVSVoA=;
        b=rD+Ey06sF3R2j7BFEWgbjXIQ+VpZAhvP9SUr0G97Jfx2fLiFFbyse2kgDtMjnZnEvK
         x944HNHUFCPxfx3VwtilngXn5E2BQMxJRyxm/TMdndAn7VD61FdvM45pshMVqs0YcgJz
         MBsWc/QcMsotbnBG8n7buJhJWF7hTXTkiOBmffFyho3+3gUghfwEB8f3Eyddc74557AS
         Gs5SxhNhB0Z2dJd4JR2x2MCubcLDnAvTurh/muSG6ymW9uLxVtI6mwURJfXohGT+e39G
         RtcQra9c+6f1q6YhvmnElR+hCTk9fodG1UYE5C+hJ2JAPEYQoZp9n/Pha0EioGGDH3pL
         xs1Q==
X-Gm-Message-State: AOAM530F9R9w+Xj3aN9ykZjJNprVbMgPkYvsPri2J9gEf7B0fv2py13I
        lT9K/nXDaSVjHRQ68GNECaBBKHYCUaD0Do6O3zd6RLV6UWubLacJF5CJEEwcdzLsmrMM4R5z8Pq
        PAhy0Lc0JjD2NxlrY0k5+
X-Received: by 2002:a05:6214:10cb:: with SMTP id r11mr5368153qvs.203.1592509597361;
        Thu, 18 Jun 2020 12:46:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJywrhpNMyyljoqo7iW7mbIgk7aOwkBo1Yv2CLk4QFD+fxF07OsuL8qL4aJVuxLYbOl5aNqUVw==
X-Received: by 2002:a05:6214:10cb:: with SMTP id r11mr5368140qvs.203.1592509597113;
        Thu, 18 Jun 2020 12:46:37 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id l188sm3605655qke.127.2020.06.18.12.46.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jun 2020 12:46:36 -0700 (PDT)
Subject: Re: [PATCH v2 0/6] add regmap & indirect access support
To:     Xu Yilun <yilun.xu@intel.com>, broonie@kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     hao.wu@intel.com, matthew.gerlach@linux.intel.com,
        russell.h.weight@intel.com
References: <1592493910-30473-1-git-send-email-yilun.xu@intel.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <1f684924-44a3-ca47-5f69-3401a6389e38@redhat.com>
Date:   Thu, 18 Jun 2020 12:46:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <1592493910-30473-1-git-send-email-yilun.xu@intel.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=trix@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This set looks good to me.

Reviewed-by : Tom Rix <trix@redhat.com>

Tom

On 6/18/20 8:25 AM, Xu Yilun wrote:
> Updated the regmap & indirect access support for spi-altera.
>
> Patch #1, #2, #3 is already applied.
> Patch #4 is an 1:1 replacement of of readl/writel with regmap_read/write
> Patch #5 introduced a new platform_device_id to support indirect access as
>          a sub device.
> Patch #6 is a minor fix.
>
> Main changes from v1: 
>  - Split the v1 Patch #4 to v2 Patch #4 & #5. 
>  - Add a new platform_device_id to support indirect access.
>  - Removed the v1 Patch #5. Now we use driver name string directly.
>  - Add Yilun's Signed-off-by for Patch #6
>
>
> Matthew Gerlach (1):
>   spi: altera: fix size mismatch on 64 bit processors
>
> Xu Yilun (5):
>   spi: altera: add 32bit data width transfer support.
>   spi: altera: add SPI core parameters support via platform data.
>   spi: altera: add platform data for slave information.
>   spi: altera: use regmap-mmio instead of direct mmio register access
>   spi: altera: support indirect access to the registers
>
>  drivers/spi/Kconfig        |   1 +
>  drivers/spi/spi-altera.c   | 177 +++++++++++++++++++++++++++++++++++++++------
>  include/linux/spi/altera.h |  29 ++++++++
>  3 files changed, 183 insertions(+), 24 deletions(-)
>  create mode 100644 include/linux/spi/altera.h
>

