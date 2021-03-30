Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D8B734E793
	for <lists+linux-spi@lfdr.de>; Tue, 30 Mar 2021 14:37:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231928AbhC3MhM (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 30 Mar 2021 08:37:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231939AbhC3Mgu (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 30 Mar 2021 08:36:50 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23F45C061574
        for <linux-spi@vger.kernel.org>; Tue, 30 Mar 2021 05:36:49 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id u10so19709214lju.7
        for <linux-spi@vger.kernel.org>; Tue, 30 Mar 2021 05:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kPzUZhjXgrzLOXbWMXp3Bx9y7tYCUcZmohZPQXutEg4=;
        b=VE7NcAe/7YBepgB7Nl6caFJLz/yc0G3+oicXrxmVx38srri65LNMBKr/xcyE/L8tuB
         YP3sSgYB5gw2mAKo2N94UGklm4qNSkZXrqhg5Z7APMMTak2MreTt5Z9soNX7XgjhG+sr
         9/xJD1NwCELnTWrpBwJL79+AFA8ZNFR1BdZohaqbxt5veK7OJAMtu9h8vzBdw+cTQIP4
         6fHgYe7TehXgf7BJUs3ycKi75yFqd3LgEmLRnok+vevt2l/w2CpfzPSkBz6+vnIpdieD
         bcI60Dg9/x4MNKxSivlT/iEIJoOcrPJ5pCCLkLxgNlzL1YRe0N30Exng/oUUSLpmD9cd
         gihw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kPzUZhjXgrzLOXbWMXp3Bx9y7tYCUcZmohZPQXutEg4=;
        b=YO3dj8T8tMmDfcO7Qb23ZIkywmM6qkwFQzWx5WYbok1acjYTtehTj+eBIwW64wxcWC
         Ps5Whj2NfyZEJhFnFUZrDi+LK74zA3jUvqTnuAV5fM6zR4iropUIwCXlqxPWqQbcbjAD
         dPq5xDBytKe49/xK6Xd4Kpt02wZxCkojXlGFMN7zT4eIIUdDZIKJ0VwwdVcxjr1nPKPK
         idLKaEq+PbGY8HRRrqQfEQ0RRiIoanUVLQTYWG4dv52nSWDUE4Yx8T9NDW810H5AJBGl
         LZ8ztu9vZsuaAIjLZIFCUhy8PMQOVpOa1WaH5cPujTtNrAbXVT09gUvbb0UvvHaPFKRd
         F1XQ==
X-Gm-Message-State: AOAM533VWp7oVntwv1BJqM+j+ohvRWnfSBENADN3VpYY522maa82pJeg
        HX+JZRmAvjEF0RVHiBczqWchL8DOM0BU602o9Es=
X-Google-Smtp-Source: ABdhPJy/5Iip/VuogOAtaL+b9kUd9NaM8fIFFT/SdMg4Tz+kuo7HnOSDdKqvwyCD5BtoohWrcIqBvPCr1Xq7WuCa1bU=
X-Received: by 2002:a2e:701:: with SMTP id 1mr20346087ljh.264.1617107807581;
 Tue, 30 Mar 2021 05:36:47 -0700 (PDT)
MIME-Version: 1.0
References: <1617107474-46079-1-git-send-email-tiantao6@hisilicon.com>
In-Reply-To: <1617107474-46079-1-git-send-email-tiantao6@hisilicon.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 30 Mar 2021 09:36:36 -0300
Message-ID: <CAOMZO5A8r8LuV_GOvi3=rdABFgWuC3ho=h2B4FwWB_Y-WCXUTg@mail.gmail.com>
Subject: Re: [PATCH v2] spi: davinci: Use of_device_get_match_data() helper
To:     Tian Tao <tiantao6@hisilicon.com>
Cc:     Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, Mar 30, 2021 at 9:30 AM Tian Tao <tiantao6@hisilicon.com> wrote:

> -       match = of_match_device(davinci_spi_of_match, &pdev->dev);
> -       if (!match)
> +       spi_data = of_device_get_match_data(&pdev->dev);
> +       if (!spi_data)

No need to check against NULL here because all compatible strings
provide .data and DT is the only mechanism to probe.

Also, this could be device_get_match_data().
