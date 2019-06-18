Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 184F349F0F
	for <lists+linux-spi@lfdr.de>; Tue, 18 Jun 2019 13:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729508AbfFRLUx (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 18 Jun 2019 07:20:53 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:43726 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729110AbfFRLUx (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 18 Jun 2019 07:20:53 -0400
Received: by mail-lf1-f65.google.com with SMTP id j29so8949051lfk.10
        for <linux-spi@vger.kernel.org>; Tue, 18 Jun 2019 04:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BqAQziBuj9AHgjLdy1ruEhnfS6TP1Hx9eyj6mxwxuVY=;
        b=beCCz7QmMZSMUGW1ehplyyYV6H2zAGH2ymXMgTQkdLJOdUIBHLM9nFnGibLF7Dvaj1
         QAqlFa+2b4aKA7v5k6dHB1lWResDnyDY/oxIf5+mVPI+5qbpa1J5ap54VLLTHtYS3+qH
         eXSCFP/0DlZ3HGcYISaktbM6Cqb0HflbOuhCSYnX5aFaRu3AEmbv3Z94xx5SLku400cO
         9t2OA5rn5FmP4EScKNLcYtP3LRTLy+A5tcEB4Mh1QQFjrENiTv8Ix/3oMGbnvK3Osu8N
         LID1ZHoEzN7uEUVPi+ZmczM3R1aoB0zkA11FYYBaOoohol9XdePy+na+RCck9pcPKyrJ
         NyjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BqAQziBuj9AHgjLdy1ruEhnfS6TP1Hx9eyj6mxwxuVY=;
        b=U5MULdtXNdRLcdPEoxFMnKnaNOC3g/dsqSs2fApo4qhjA5QCqdZmCOXeiNFAQfm4qx
         QqMPlrhR9zgM/hsaOjI/iHxsOblPx8TkiKCyj5OQ0POA4Kd57P8nU3flqSRpZH83BJq9
         WtGvbo7BylKRKScDul0F15MBok7mv82Xxrul1ig1/X/9+657zFxtp1hQjiue7IDhXhRb
         yoLI1sdiKLp8gCgMGQcxxFSFc9rcdcW2o0mpnA6b8a9G8RvowOB5IyyVY2unq+7JIdeQ
         can5MRyg3/T4NVGbuhQhYu8Oj+V3yBWTqoFmg+avreSw2UTq5vadDWJxtxON5W6wRPyg
         EiwA==
X-Gm-Message-State: APjAAAVSic8DMhbIpbUflwVwJWularlH0sBpRGIyHorSdwBA157bikGN
        nCpiNnwvrX2Scj2ID6MB4cR5ixJaq0EOdkpkW3aS6w==
X-Google-Smtp-Source: APXvYqy9dosDTTJ7Ccl2s4o9bC+yfVHz93nXQ4Yj2pRnpWkk4JjCx0Blsyav6g7HJtf+Qo6SyexVG1tOvtjnqlkeZFU=
X-Received: by 2002:a05:6512:21c:: with SMTP id a28mr13786559lfo.14.1560856850926;
 Tue, 18 Jun 2019 04:20:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190617060957.16171-1-masahisa.kojima@linaro.org>
 <20190617101741.GK5316@sirena.org.uk> <CAKv+Gu-DYzRRG82t27nFZKeLOPzCYphY=AQCQy78=m591rXs_A@mail.gmail.com>
 <20190617114630.GO5316@sirena.org.uk> <CADQ0-X_1kNChYr_vvOiafghk8h1AcERaGYWjo61ATLXy0_f_UA@mail.gmail.com>
 <20190618105714.GL5316@sirena.org.uk>
In-Reply-To: <20190618105714.GL5316@sirena.org.uk>
From:   Masahisa Kojima <masahisa.kojima@linaro.org>
Date:   Tue, 18 Jun 2019 20:20:39 +0900
Message-ID: <CADQ0-X-HSPMCY+NY5g_53KY18M2E-W9VJiUOrxB7oDy0hx+EeQ@mail.gmail.com>
Subject: Re: [PATCH] spi: Kconfig: spi-synquacer: Added ARM and ARM64 dependence
To:     Mark Brown <broonie@kernel.org>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        kbuild test robot <lkp@intel.com>, kbuild-all@01.org,
        linux-spi <linux-spi@vger.kernel.org>,
        Jaswinder Singh <jaswinder.singh@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, 18 Jun 2019 at 19:57, Mark Brown <broonie@kernel.org> wrote:
>
> On Tue, Jun 18, 2019 at 05:13:57PM +0900, Masahisa Kojima wrote:
>
> Please don't top post, reply in line with needed context.  This allows
> readers to readily follow the flow of conversation and understand what
> you are talking about and also helps ensure that everything in the
> discussion is being addressed.

I'm sorry, I understood.

> > There was a patch to address same compile error.
> > https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1982194.html
> >
> > Does it preferable solution to use iowrite32_rep() series?
>
> If there's a patch that removes the need to have a hard dependency on
> the particular architectures that'd definitely be better.  Separately a
> patch adding a depends on the architectures with || COMPILE_TEST would
> be OK though and potentially useful like Ard says.

I will try to use iowrite32_rep() series.
