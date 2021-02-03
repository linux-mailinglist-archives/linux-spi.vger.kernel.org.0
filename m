Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D45F430E096
	for <lists+linux-spi@lfdr.de>; Wed,  3 Feb 2021 18:11:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231476AbhBCRLW (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 3 Feb 2021 12:11:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231327AbhBCRLH (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 3 Feb 2021 12:11:07 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5CC6C0613D6;
        Wed,  3 Feb 2021 09:10:27 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id m22so223271lfg.5;
        Wed, 03 Feb 2021 09:10:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fyY8d5I5dl5G2a2MMTbv5ITc6nGE4sbSEreaP7ybJ6U=;
        b=MXc+sUiC1EIsn6bE6WhyVAvNSzzUqwdZo0G5POv3fdxieDhcXEXYh1NlbthauCO+6Q
         5DHsP7YlErzcvFkDDxLRRoB9+Rx+Dqe4QqQSFrIogS+QfvEUnOkxkxqOPvBZHBP8azuh
         L4wMme1BqWu3OZXOBc8xSVx2HgJjyGhyJyi9uFrXCXXJMjeHmmwh3ZckyQI8f/BNisb2
         p8nw0LoBfUnD0eNOJlYAh57kvEXbMidXsjWAQ2jkj+/gzNd0ZU4L5tLoKSELFXej9TaP
         ZZ1+A+/WewE2jJ2Z4CHz7h6VZOSOSEx1XulSIpx2n325oVkIGyO9vXZ30riNdnVY7KTq
         UzWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fyY8d5I5dl5G2a2MMTbv5ITc6nGE4sbSEreaP7ybJ6U=;
        b=JWYY2kAm0ptJfvkkd3QezS6+0Jdv2ZT/Je5SJZu+f+o6WpFLOJ/gjRqJKPQ7WhxNHR
         pJ0cBt+VYe63wKWz1qWxElcTAtrlpgL7KQJ/jO9YO+tJ+oV39NzDzjXDvRLwpLJnSjCG
         TfAs4KPD7jDmyXNYkL80PZt8lFppl1payPnb09b6EAhscBebCRQGRt/8B8+kF42Eu+yq
         KCItHYohEFk+FhVLZAD84Co6rnpEFILhrDO34tciMgrJku4KowPo20sqvOMLhCQXw5+Y
         oxHf9RK310Uz/DJ/CdOFlt0RvgriYJLfd68zDhEp0ksvLuzWAS9BAGAN3XuOnP8EMveR
         nYFA==
X-Gm-Message-State: AOAM530r+x45KKZWxNxEWBBXw2ZdPNw7J8EQAsnQP5NuJPGz/9pWb3QG
        9Z3KylEEwsFBLgJSRPISKNbu6tiaB6oPT4e8PnQ=
X-Google-Smtp-Source: ABdhPJxAflFjpPn8qqnOcv6df57tjKkl/mNNYN2wcCoxWjE/2vPG+YYFOm+TQ96XizshcNX0hqdqt1kdT4QlVhGann0=
X-Received: by 2002:a05:6512:3251:: with SMTP id c17mr2132862lfr.443.1612372226193;
 Wed, 03 Feb 2021 09:10:26 -0800 (PST)
MIME-Version: 1.0
References: <20210203170245.31236-1-miquel.raynal@bootlin.com>
In-Reply-To: <20210203170245.31236-1-miquel.raynal@bootlin.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 3 Feb 2021 14:10:15 -0300
Message-ID: <CAOMZO5AG5HjYa6d9oNrFjmpepu51md3obcqcLo9PgOZMo4T9PQ@mail.gmail.com>
Subject: Re: [PATCH] spi: Fix the logic around the maximum speed
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        zhengxunli@mxic.com.tw, juliensu@mxic.com.tw, ycllin@mxic.com.tw
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Miquel,

On Wed, Feb 3, 2021 at 2:06 PM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
>
> Commit 9326e4f1e5dd ("spi: Limit the spi device max speed to controller's max speed")
> rationaly introduced a new condition on which the device's maximum
> speed would be set to the controller's one: if the device advertizes a
> higher speed than the one supported by the controller.

Already fixed:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=6820e812dafb4258bc14692f686eec5bde6fba86
