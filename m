Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC5682512C4
	for <lists+linux-spi@lfdr.de>; Tue, 25 Aug 2020 09:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729372AbgHYHKj (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 25 Aug 2020 03:10:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729276AbgHYHKf (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 25 Aug 2020 03:10:35 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F571C061574;
        Tue, 25 Aug 2020 00:10:35 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id bo3so15114705ejb.11;
        Tue, 25 Aug 2020 00:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gPWggGnZfKXzYv43SZ5/w/OGptcwgH/cYoepbnpuXSU=;
        b=YQx6miclATuS6VbE6jZFDWN40JxQ/1nlhUefrciReWKCPK1PB5FiMSBPlYM1zxuGwz
         DPQCBv3VBF0bfZxCQGjeVhyw94aZ2SuYv34fLToG/A3EJPKRqfmIU8jB3mKcre2iEphq
         gf1mzRXOzxB/Ek7w8xs6x3QkGetykd+ka7NaU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gPWggGnZfKXzYv43SZ5/w/OGptcwgH/cYoepbnpuXSU=;
        b=hqhve2arDBbz7elUYiSxB2lOMOu7xgnllKMqI5cH389PO/qf2P1MaBfLrAz51Fl4wa
         wACZiGlE/lYx4tTzdXi8YQEASlwbDElX7TaS64TFqkmlurf/48LK1eM8MwRZb4l/PsQK
         GRjnzMrfz4Nbj60lqg5lkTVgfL4kc0QJNiD9soh4UWknYIRTZHGW8TT9aLkrXL9uDQm6
         NdGndeyNoyV8JqPEVpim+gbb22UjTL4d5m0LwiKdQkTmfaPeM/3nhWTmb5DXeCjtXNxy
         8Iux5dzIqXQiVnyqdye0hrHz3OYdDZA7f0gUUCYVlVPFp59yzGNTKr9yfyROrPPJCK6m
         rHOw==
X-Gm-Message-State: AOAM531Y6VwBiF/02Lkamhy2EYQIAejUwHW7FxmaymnhX4fvMMB1KJNh
        Tl5BwTEceI2WpFf3dMKS5kZhfNc4jWbOuge0IALK3EqIjROx7g==
X-Google-Smtp-Source: ABdhPJxT7sLAof3wgdsZrFIY0FgjJ9rUTWN5mlEBLHxkNznDjkfvRa3dUDnJhYrwxtShLAiGNnWtLnIVtbS/FI/GNSM=
X-Received: by 2002:a17:906:b34c:: with SMTP id cd12mr8653384ejb.504.1598339433785;
 Tue, 25 Aug 2020 00:10:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200820170228.42053-1-eajames@linux.ibm.com> <20200820170228.42053-3-eajames@linux.ibm.com>
 <20200820171257.GG5854@sirena.org.uk> <660034d2-c808-3a4b-6ecc-be1769e8a017@linux.ibm.com>
In-Reply-To: <660034d2-c808-3a4b-6ecc-be1769e8a017@linux.ibm.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Tue, 25 Aug 2020 07:10:21 +0000
Message-ID: <CACPK8XcJnDjt6N9KHNEG7Mhy7=mWX2OYA-Z0tfBbvHdsJC7apA@mail.gmail.com>
Subject: Re: [PATCH 2/7] spi: fsi: Fix clock running too fast
To:     Eddie James <eajames@linux.ibm.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Brad Bishop <bradleyb@fuzziesquirrel.com>,
        Rob Herring <robh+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, 20 Aug 2020 at 21:06, Eddie James <eajames@linux.ibm.com> wrote:
>
>
> On 8/20/20 12:12 PM, Mark Brown wrote:
> > On Thu, Aug 20, 2020 at 12:02:23PM -0500, Eddie James wrote:
> >> From: Brad Bishop <bradleyb@fuzziesquirrel.com>
> >>
> >> Use a clock divider tuned to a 200MHz FSI clock.  Use of the previous
> >> divider at 200MHz results in corrupt data from endpoint devices. Ideally
> >> the clock divider would be calculated from the FSI clock, but that
> >> would require some significant work on the FSI driver.
> > Presumably this divider was chosen for FSI clocks that aren't 200MHz -
> > how will those be handled?
>
>
> They aren't handled at the moment, but 200MHz FSI represents the worst
> case, as it's the maximum. Slower FSI clocks will simply result in
> slower SPI clocks.

That would be a good addition to the commit message, as I had the same
question too.

Cheers,

Joel
