Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 774552E8793
	for <lists+linux-spi@lfdr.de>; Sat,  2 Jan 2021 15:12:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726575AbhABOMI (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 2 Jan 2021 09:12:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726561AbhABOMH (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 2 Jan 2021 09:12:07 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53AC4C061573;
        Sat,  2 Jan 2021 06:11:27 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id o13so53528087lfr.3;
        Sat, 02 Jan 2021 06:11:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lKECTOna1BDF0maAnj4w2Lve7i91JSIa8BduewhrksY=;
        b=NDuuVGNsXQJ3AgFeDJGw5lU+T4JvAqjJly4DhRp0dpIRlZPeN/zPOZ1H2GufeQC49+
         uPl0d9GiHfqLvxL8xuXQOKdJWCNFKMTjvBAMutHuHJc1leS0a9QzSUpXmLDYdke375e8
         OX5dij6iorXtxeC9d1YkYmSSJ+VoLgrbkrVAndZBTmePVUeo0TN7Ns7+eoPkzMeJtxKn
         bDnB1zhkCyE7X0XTI/c9FqSSOd2Jz/2PS4sgSszIMDiRiskbER0xpU3kv0Hg7LbSQaFo
         RC7D+7RWqQ6P+opwSQ9yQaqyolwywlE8zSx5hSMgt4Tvve45kYMsntoqzIZBFDKUjROJ
         SlKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lKECTOna1BDF0maAnj4w2Lve7i91JSIa8BduewhrksY=;
        b=jHSQGBhKmHttbFtvm2zrkAO7wPqSygTuBtUIqoYS5O4i039OHcvoR1z8QaVZYStH+O
         jj9NX9Hk28rJZivBgaabM8wyZA3eGSjvPV2NJUAb0yBo6La1Y8pPg4zfkinKoMYUrWf6
         bKQjMjcpO1CN6WWccsh251xBaVglF2mnNl98XCnXBt3n/tVcxIrlSCM0IayagC9/PMyp
         WnTsfug35McYpYlh8Ym4oBSrY/Ukl95+CgL5+p1oJ5KdvYRzSgYeLy0jVHOH0yQCRbyM
         zZSowkRzLpTgN5uvnQC3Wwouk58J5hy+f1kO/IPUEFa9ieBTXKD9ugg70XGByqPXCEtL
         o8UQ==
X-Gm-Message-State: AOAM531vqhh9JvhhkfdtgaC4p06kITR/BE1DP8SGlcTZ8BXu+pmpAS0J
        +za77iLOU+xmcN7GeIwp1OmI/ve3qUfND+nuKicaC9SJKHs=
X-Google-Smtp-Source: ABdhPJwt+k3ECVO1h2HKyNAMYaEKiaqLX4f7x7rfDcywNv9iiTawyvbmNplfYdONM0FC6KK07ca9CM9DM2l9ilOzvBE=
X-Received: by 2002:a2e:b80c:: with SMTP id u12mr30996412ljo.490.1609596685750;
 Sat, 02 Jan 2021 06:11:25 -0800 (PST)
MIME-Version: 1.0
References: <1609556386-19422-1-git-send-email-yilun.xu@intel.com>
In-Reply-To: <1609556386-19422-1-git-send-email-yilun.xu@intel.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Sat, 2 Jan 2021 11:11:14 -0300
Message-ID: <CAOMZO5AnaiDhR_PpGtyeneE_49=imOgawZTObxb7i0ibcfkKtQ@mail.gmail.com>
Subject: Re: [PATCH v2] spi: fix the divide by 0 error when calculating xfer
 waiting time
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>, trix@redhat.com,
        lgoncalv@redhat.com, hao.wu@intel.com,
        matthew.gerlach@linux.intel.com, russell.h.weight@intel.com,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sat, Jan 2, 2021 at 12:07 AM Xu Yilun <yilun.xu@intel.com> wrote:
>
> The xfer waiting time is the result of xfer->len / xfer->speed_hz. This
> patch makes the assumption of 1khz xfer speed if the xfer->speed_hz is

You missed to update the commit log to 100kHz.
