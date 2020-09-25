Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73F00278206
	for <lists+linux-spi@lfdr.de>; Fri, 25 Sep 2020 09:53:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727363AbgIYHxO (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 25 Sep 2020 03:53:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727063AbgIYHxN (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 25 Sep 2020 03:53:13 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC315C0613CE;
        Fri, 25 Sep 2020 00:53:13 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id h2so1459170ilo.12;
        Fri, 25 Sep 2020 00:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c25OWVlYr3r4Zg73+hgQ+FOM6zKBeGJ84JdXLPHXx8I=;
        b=El5vlfyFAp4rhbHtluPcO/SDAUVfZbEz0brwMeEUflGfzx/VqBAZF9s/RnrI2wdMB+
         IDMVVpmjwHdDq4hsur3vvdQZc0uyMZyvFh5tOWqznd6OtXz3gY++1691QN8iikJGcKz7
         epqpJNxrJKQ3h1sQXG9loYVOiG2kx3ng4H9oG5Nga3lXK7xbtIgJy86F4AgwHNMvLlt9
         PRV5QnZKF9wbDJTONxKE/zxHd4XNL6oT5ffF4sSmd36kuC9SEo++bJ8l0aU36ahgQe38
         +RlHD/uhUOZi7wMrZGfvCxqzv+ECiG+eOXxaCFA/g39wIJfqiNLg4eHTC8fFwkm2fs6E
         eU3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c25OWVlYr3r4Zg73+hgQ+FOM6zKBeGJ84JdXLPHXx8I=;
        b=dQlXAbndpJHhQq381XhEqevcNfGW2CMPQDtN1GnPPJGePuu8TCXVvlhl+Xe5rBWvDe
         AwBu0wJ0WH7jYtjXi8AkR0LowhcaH+my2i0MIAn4SGwb1MDvigXZYh4rFcQh1S9B5x50
         pI4ATAoWGUdloRMITpZf3D4SDZmvFZGm3CFVOci5MX178RUJx5zRaUmgomlHDLqKcmLb
         koFVAKlQLpnxHVWbtAatB/VHeEtZoEwCuDNdnG2Jtf1jiF4+zuh+AKuKCdrx6imu2BKm
         G7pK9GRL80rlLsit50r6mrjXAJ3Txi0Dmjtf4W5Tz3wY6sNbva/RcdcsSP941hjFB1WU
         0DGw==
X-Gm-Message-State: AOAM530L2UgLBI7E+2xyYm1ipdStDvPZRYHrv0TylmFU8LO1rHtZgKk9
        iszQtVgpQKVSJb1scuvFVFa6GoIU78yVntsY6ICXvHZdkv0=
X-Google-Smtp-Source: ABdhPJxVcorRXiGmUxNix8OWbEeDvEZT9K/TbGuPqcdFB8mbYgGuy2aK6sIlGnBZMRKPFpSbkIc506QeSjw0ph33bQw=
X-Received: by 2002:a92:c10c:: with SMTP id p12mr2108245ile.274.1601020393169;
 Fri, 25 Sep 2020 00:53:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200925065418.1077472-1-ikjn@chromium.org> <20200925145255.v3.3.I7a3fc5678a81654574e8852d920db94bcc4d3eb8@changeid>
In-Reply-To: <20200925145255.v3.3.I7a3fc5678a81654574e8852d920db94bcc4d3eb8@changeid>
From:   Chuanhong Guo <gch981213@gmail.com>
Date:   Fri, 25 Sep 2020 15:53:02 +0800
Message-ID: <CAJsYDVLmqCBW4OHVmKDCBb+BE=4gZeOao8khZdx77k3=V9vCgw@mail.gmail.com>
Subject: Re: [PATCH v3 3/6] spi: spi-mtk-nor: support 7 bytes transfer of
 generic spi
To:     Ikjoon Jang <ikjn@chromium.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, linux-spi@vger.kernel.org,
        linux-mtd@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

HI!
One more comment:
On Fri, Sep 25, 2020 at 2:55 PM Ikjoon Jang <ikjn@chromium.org> wrote:
> +static bool mtk_nor_check_prg(const struct spi_mem_op *op)
> +{
> +       size_t len = op->cmd.nbytes + op->addr.nbytes + op->dummy.nbytes;
> +
> +       if (len > MTK_NOR_PRG_MAX_SIZE)
> +               return false;
> +
> +       if (!op->data.nbytes)
> +               return true;
> +
> +       if (op->data.dir == SPI_MEM_DATA_OUT)
> +               return ((len + op->data.nbytes) <= MTK_NOR_PRG_MAX_SIZE);
> +       else if (op->data.dir == SPI_MEM_DATA_IN)
> +               return ((len + op->data.nbytes) <= MTK_NOR_PRG_MAX_CYCLES);

You need to consider the existence of adjust_op_size in supports_op as well.
This mtk_nor_check_prg still rejects SFDP reading command from spi-nor
driver altogether.

-- 
Regards,
Chuanhong Guo
