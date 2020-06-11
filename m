Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7498D1F6864
	for <lists+linux-spi@lfdr.de>; Thu, 11 Jun 2020 14:56:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726537AbgFKM4l (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 11 Jun 2020 08:56:41 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:30638 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726346AbgFKM4l (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 11 Jun 2020 08:56:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591880199;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Fq4jWTmxvdTOixqCSNHPWC+W1UeHSFDB5a+MOgnJLHI=;
        b=Kt8aYFcKtx2IgPLbfV1/r5bdDxq0nzLghzV9ZtxagQFzeiDufE03acC49Ct0Sba5rzYB90
        L0OaDxqpbaPCh+WHGHztJguE0Gdd2b+/oHgPYQffuKfW1LJyzC49NnyAYrzToZSkMrYIP9
        FlnTCpuglZXXmZBeTghe8Tw7yquRorc=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-499-8r8peULgN8yvMtj1vxG2Bw-1; Thu, 11 Jun 2020 08:56:38 -0400
X-MC-Unique: 8r8peULgN8yvMtj1vxG2Bw-1
Received: by mail-qt1-f198.google.com with SMTP id q21so4697839qtn.20
        for <linux-spi@vger.kernel.org>; Thu, 11 Jun 2020 05:56:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Fq4jWTmxvdTOixqCSNHPWC+W1UeHSFDB5a+MOgnJLHI=;
        b=tB41W83xfYTpj5bUyXITCkzORrEWQAOfoKOkRC2Vakxu9yU7xYj++UWbSm4b3cXR5+
         XXJjgrGLa1nfWpa/Mqv1r1rHKRddqZvnX7mRrgTFomdfa1yQJWRKAnFJziih9wc0x7Em
         31W+aOcgQ3vCeA+I7LeFD2eClrwW0ZwMypwpPUyhbgZ9OIdn+viUBlYq58KW5g4CBaHe
         fz/oZ33HdTC1616I/WNBPL+YQpXvQMqXXWFSG5Mm5NPqlRm7WpAWvpjTWOnoKnrFGArh
         eNa2wU9i/8yTKJ0YCrXRaT0/lIbrgwxZlSfED9tFew7XBbXxaMORzNHOs/KcRzu2CF4E
         uiZg==
X-Gm-Message-State: AOAM533FZA6D3D6/4h7Yuu7DxO/F7KZeKtrk4CkOWzLKQq2DbOTjYbZN
        5UZtfB9kwwj+qsRn7V5lo6cOf3LupV3mbuH/EsKCV5SyXB+ntDmJKD6DxiTrJOK3yjocAi8sCI2
        nBxDH1qf7+J4/bFaArYrF
X-Received: by 2002:a05:6214:b33:: with SMTP id w19mr7223587qvj.7.1591880197758;
        Thu, 11 Jun 2020 05:56:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx+JyKVnjOWvjSt9Z4+PqIeU1E00Ib2Tef8IcgZTQ1YgELkIq0HkZauAQyYv/J2UaWpMgxv7Q==
X-Received: by 2002:a05:6214:b33:: with SMTP id w19mr7223575qvj.7.1591880197557;
        Thu, 11 Jun 2020 05:56:37 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id b4sm2229646qtp.63.2020.06.11.05.56.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jun 2020 05:56:36 -0700 (PDT)
Subject: Re: [PATCH 0/6] Add more configuration and regmap support for
 spi-altera
To:     Xu Yilun <yilun.xu@intel.com>, broonie@kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     hao.wu@intel.com, matthew.gerlach@linux.intel.com,
        russell.h.weight@intel.com
References: <1591845911-10197-1-git-send-email-yilun.xu@intel.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <fb4a6f25-9f93-7618-d64e-20b93b1fcade@redhat.com>
Date:   Thu, 11 Jun 2020 05:56:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <1591845911-10197-1-git-send-email-yilun.xu@intel.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This patchset looks good to me.

Reviewed-by: Tom Rix <trix@redhat.com>

Thanks,

Tom

On 6/10/20 8:25 PM, Xu Yilun wrote:
> This patchset adds platform_data for spi-altera, to enable more IP
> configurations, and creating specific spi client devices. It also adds
> regmap support, to enable the indirect access to this IP.
>
> We have a PCIE based FPGA platform which integrates this IP to communicate
> with a BMC chip (Intel MAX10) over SPI. The IP is configured as 32bit data
> width. There is also an indirect access interface in FPGA for host to
> access the registers of this IP. This patchset enables this use case.
>
> Matthew Gerlach (1):
>   spi: altera: fix size mismatch on 64 bit processors
>
> Xu Yilun (5):
>   spi: altera: add 32bit data width transfer support.
>   spi: altera: add SPI core parameters support via platform data.
>   spi: altera: add platform data for slave information.
>   spi: altera: use regmap instead of direct mmio register access
>   spi: altera: move driver name string to header file
>
>  drivers/spi/Kconfig        |   1 +
>  drivers/spi/spi-altera.c   | 161 +++++++++++++++++++++++++++++++++++++--------
>  include/linux/spi/altera.h |  37 +++++++++++
>  3 files changed, 171 insertions(+), 28 deletions(-)
>  create mode 100644 include/linux/spi/altera.h
>

