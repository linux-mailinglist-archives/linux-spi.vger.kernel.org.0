Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F0C7186ADC
	for <lists+linux-spi@lfdr.de>; Mon, 16 Mar 2020 13:29:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730920AbgCPM3X (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 16 Mar 2020 08:29:23 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:41169 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730634AbgCPM3X (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 16 Mar 2020 08:29:23 -0400
Received: by mail-ed1-f67.google.com with SMTP id v6so6642660edw.8;
        Mon, 16 Mar 2020 05:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5VLlWvipsZ7W0tYIxJnPVf/6XKPbpskbmNyG86YQGoM=;
        b=qNyy3jh1WuItYeIcYhg5ZYOwgepnwQimVsdDTcaQWGqOcVNLKy0n5GXeY6Cvdc+TGe
         5UVk9vH3++p7+bRz5xR2noTMx8RBioAdaNboOGHxHAhP85J6+JK2LN6+dEnKqhsHwL8k
         xzPZgb2s+AZWlMO10+KMHBJVzWdQavh1+PBJo0z3AWvCwcXG9IdX5o8P3/INBD/UrDoS
         aoeggo2AaXPeXDz2i7dKdVkCgrsrV3Wc0R0J/QjhnwhkEG+ygBhh2V96O7xSWjKiMBF1
         Y/FRBQaAILFTjHZwYBGrMPLM0zTAqexPUgnuENdgAyYexS/hNzZ5P+gxTwGSK8W0/tbe
         uT5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5VLlWvipsZ7W0tYIxJnPVf/6XKPbpskbmNyG86YQGoM=;
        b=r6o4VvtKp9JHEkwwdVERisPTMjpEQjuZAYtVwTheg0iX3rsTBPE23CpOpdhpLdEoB6
         uD8WDV8lK1U24xKCXQN360lq9qQuV179m2uqC6guZtkvVjqsLebO3adc8xd8bZPJpBsb
         cvIkpg8xtS82Lv7rGq2B7dG3a4uHlYNy0EPfTM2cwH4jatNkXe/7Awd09WzcdrTch5EO
         FUk2ct+ZHrAN38FWJxlO3Tika4rmHGUWGogA6qTFWsHwd55XVPq/+p9g0GMzZIkBuwHK
         sOW/fRMdAnbH15eDAY+YM0amYj0hem9qFHuDiPcxQGIj77JSMtqNzPVVrZOntsF3diZe
         WWuw==
X-Gm-Message-State: ANhLgQ3L9AylE+32vE07dwrOB4//sIGRmZWdedMpdhAGffmeavII+RVh
        P1lUlOsr7vH2BMXQbz0RCF8x/4yHrZ1i3ayitiVQNiXRTZ0=
X-Google-Smtp-Source: ADFU+vvAgalTa8Mpz3WYGoCBmb/3HT41xmXmIHxmtjzFqnt22vXajdbe97TkxeYIcfS8WjEoGUE6TiNp1xxoxtvfUcY=
X-Received: by 2002:a50:e041:: with SMTP id g1mr15381431edl.118.1584361760917;
 Mon, 16 Mar 2020 05:29:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200314224340.1544-1-olteanv@gmail.com> <20200314224340.1544-7-olteanv@gmail.com>
 <20200316122613.GE5010@sirena.org.uk>
In-Reply-To: <20200316122613.GE5010@sirena.org.uk>
From:   Vladimir Oltean <olteanv@gmail.com>
Date:   Mon, 16 Mar 2020 14:29:09 +0200
Message-ID: <CA+h21hqRV+HmAz4QGyH9ZtcFWzeCKczitcn+mfTdwAC7ZobdDw@mail.gmail.com>
Subject: Re: [PATCH v3 06/12] spi: spi-fsl-dspi: Replace interruptible wait
 queue with a simple completion
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, Esben Haabendal <eha@deif.com>,
        angelo@sysam.it, andrew.smirnov@gmail.com,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Wei Chen <weic@nvidia.com>, Mohamed Hosny <mhosny@nvidia.com>,
        Michael Walle <michael@walle.cc>, peng.ma@nxp.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Mark,

On Mon, 16 Mar 2020 at 14:26, Mark Brown <broonie@kernel.org> wrote:
>
> On Sun, Mar 15, 2020 at 12:43:34AM +0200, Vladimir Oltean wrote:
>
> > The wait queue was actually restructured as a completion, after polling
> > other drivers for the most "popular" approach.
>
> > Fixes: 349ad66c0ab0 ("spi:Add Freescale DSPI driver for Vybrid VF610 platform")
>
> Fixes should generally go at the start of the series to make sure that
> they can be applied without any dependencies on the rest of the series
> and sent to mainline before the merge window.

Correct, the real problem is that I forgot to add a Fixes: tag for
patch 5. I'll do that now.

Thanks,
-Vladimir
