Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 912A718A07B
	for <lists+linux-spi@lfdr.de>; Wed, 18 Mar 2020 17:31:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbgCRQbP (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 18 Mar 2020 12:31:15 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:37336 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726916AbgCRQbP (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 18 Mar 2020 12:31:15 -0400
Received: by mail-lj1-f196.google.com with SMTP id r24so27837902ljd.4
        for <linux-spi@vger.kernel.org>; Wed, 18 Mar 2020 09:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TnhTytcg8/2Cxze55Eg3TEpzriYoiMzt5B1xeuc9CoY=;
        b=FGK222eshqJqCPvE2m2PuKqq+bjIHzU2tnb5kXur4flSPtAfo4pp9ZgJvNZNB7M4+E
         dPLzdS6HZrLY+LVoKNQVV8HWEnhXFMk+h2uQFclD5ic0GzsQzn3gr8b3EVh18LxZ7Iwc
         6hl3OQ3EZglFarqVOjy1An2rgBl9kpceeR9QY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TnhTytcg8/2Cxze55Eg3TEpzriYoiMzt5B1xeuc9CoY=;
        b=DoquS6C9MZ0hZBqJeadURXhVcXLq2g1FznOioEV1s6/kg0Ltmg4uWqN1EvZ0vhN+jA
         fkPrHg1apvFATBu+Lhn255OyWPHnAlLnaM+39JGgbDqW0jvq/SEP6EncsUE395hy07eM
         R8pARlqclY0h+knqyFwsywmA+twWQGYOPHIIRp86YtVwrUGacS3mjdPqhv0K5A6o/rDS
         ZVLJFoGbDGdhxlAcdnAXdpHc7v9qXA4n4VSfZpGD26zMlXxndyRJMhbrJ1KHI0O7KmSw
         r7HIqurUdH4h8/RArjQic6U1pC0PSXh4jKMlnCqq3vakE76uqimK6w6cbeOuHV1H2KSL
         hR0w==
X-Gm-Message-State: ANhLgQ2OdMbOMdRugkSgBf3LxbWp8/bbWhMHLs+X86+NETOsnczpXPzy
        aSsNTrJEQxyc31ffUF8j6ydx4UxkR10=
X-Google-Smtp-Source: ADFU+vs06LR/xKBndtIOzmvrQRQyzboH33+jQvx8Y/T01I3foDxuooCWGH49wQ2jH4xAIiaSPMESWQ==
X-Received: by 2002:a2e:3615:: with SMTP id d21mr2930923lja.213.1584549070514;
        Wed, 18 Mar 2020 09:31:10 -0700 (PDT)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id h9sm1486307ljk.96.2020.03.18.09.31.09
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Mar 2020 09:31:09 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id o10so27778059ljc.8
        for <linux-spi@vger.kernel.org>; Wed, 18 Mar 2020 09:31:09 -0700 (PDT)
X-Received: by 2002:a2e:8991:: with SMTP id c17mr2989954lji.278.1584549068513;
 Wed, 18 Mar 2020 09:31:08 -0700 (PDT)
MIME-Version: 1.0
References: <1584105134-13583-1-git-send-email-akashast@codeaurora.org>
 <1584105134-13583-8-git-send-email-akashast@codeaurora.org>
 <20200314005817.GN144492@google.com> <3aeb3083-2a31-b269-510d-eb608ff14ce5@codeaurora.org>
 <CAE=gft58QsgTCUHMHKJhcM9ZxAeMiY16CrbNv2HaTCRqwtmt7A@mail.gmail.com> <e2ee1a60-a379-5c78-355a-64aad451a944@codeaurora.org>
In-Reply-To: <e2ee1a60-a379-5c78-355a-64aad451a944@codeaurora.org>
From:   Evan Green <evgreen@chromium.org>
Date:   Wed, 18 Mar 2020 09:30:31 -0700
X-Gmail-Original-Message-ID: <CAE=gft4xL9+GN2NrM9ewyPg0Fog3pnf_sLGjWRNOg7KynNh-Dg@mail.gmail.com>
Message-ID: <CAE=gft4xL9+GN2NrM9ewyPg0Fog3pnf_sLGjWRNOg7KynNh-Dg@mail.gmail.com>
Subject: Re: [PATCH V2 7/8] spi: spi-qcom-qspi: Add interconnect support
To:     Akash Asthana <akashast@codeaurora.org>
Cc:     Matthias Kaehlcke <mka@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        wsa@the-dreams.de, Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>, linux-i2c@vger.kernel.org,
        linux-spi@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Stephen Boyd <swboyd@chromium.org>,
        Manu Gautam <mgautam@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-serial@vger.kernel.org,
        Doug Anderson <dianders@chromium.org>,
        Georgi Djakov <georgi.djakov@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, Mar 18, 2020 at 6:48 AM Akash Asthana <akashast@codeaurora.org> wrote:
>
> Hi Evan,
>
> On 3/18/2020 12:38 AM, Evan Green wrote:
> > On Tue, Mar 17, 2020 at 5:13 AM Akash Asthana <akashast@codeaurora.org> wrote:
> >> Hi Matthias,
> >>
> >> On 3/14/2020 6:28 AM, Matthias Kaehlcke wrote:
> >>> Hi,
> >>>
> >>> On Fri, Mar 13, 2020 at 06:42:13PM +0530, Akash Asthana wrote:
> >>>> Get the interconnect paths for QSPI device and vote according to the
> >>>> current bus speed of the driver.
> >>>>
> >>>> Signed-off-by: Akash Asthana <akashast@codeaurora.org>
> >>>> ---
> >>>>    - As per Bjorn's comment, introduced and using devm_of_icc_get API for getting
> >>>>      path handle
> >>>>    - As per Matthias comment, added error handling for icc_set_bw call
> >>>>
> >>>>    drivers/spi/spi-qcom-qspi.c | 46 ++++++++++++++++++++++++++++++++++++++++++++-
> >>>>    1 file changed, 45 insertions(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/drivers/spi/spi-qcom-qspi.c b/drivers/spi/spi-qcom-qspi.c
> >>>> index 3c4f83b..ad48f43 100644
> >>>> --- a/drivers/spi/spi-qcom-qspi.c
> >>>> +++ b/drivers/spi/spi-qcom-qspi.c
> >>>> @@ -2,6 +2,7 @@
> >>>>    // Copyright (c) 2017-2018, The Linux foundation. All rights reserved.
> >>>>
> >>>>    #include <linux/clk.h>
> >>>> +#include <linux/interconnect.h>
> >>>>    #include <linux/interrupt.h>
> >>>>    #include <linux/io.h>
> >>>>    #include <linux/module.h>
> >>>> @@ -139,7 +140,10 @@ struct qcom_qspi {
> >>>>       struct device *dev;
> >>>>       struct clk_bulk_data *clks;
> >>>>       struct qspi_xfer xfer;
> >>>> -    /* Lock to protect xfer and IRQ accessed registers */
> >>>> +    struct icc_path *icc_path_cpu_to_qspi;
> >>>> +    unsigned int avg_bw_cpu;
> >>>> +    unsigned int peak_bw_cpu;
> >>> This triplet is a recurring pattern, and is probably not limited to geni SE/QSPI.
> >>> On https://patchwork.kernel.org/patch/11436889/#23221925 I suggested the creation
> >>> of a geni SE specific struct, however adding a generic convenience struct to
> >>> 'linux/interconnect.h' might be the better solution:
> >>>
> >>> struct icc_client {
> >>>        struct icc_path *path;
> >>>        unsigned int avg_bw;
> >>>        unsigned int peak_bw;
> >>> };
> >>>
> >>> I'm sure there are better names for it, but this would be the idea.
> >> Yeah, I think introducing this to ICC header would be better solution.
> > +Georgi
> >
> > I'm not as convinced this structure is generally useful and belongs in
> > the interconnect core. The thing that strikes me as weird with putting
> > it in the core is now we're saving these values both inside and
> > outside the interconnect core.
> IIUC, you meant to say struct icc_req(inside icc_path) will be saving
> avg_bw and peak_bw so no need to save it outside icc_path?

Correct, it seems silly to store the same set of values twice in the
framework, but with different semantics about who's watching it.
-Evan
