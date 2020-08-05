Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DFFC23CD93
	for <lists+linux-spi@lfdr.de>; Wed,  5 Aug 2020 19:39:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727909AbgHERi5 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 5 Aug 2020 13:38:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728370AbgHERiT (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 5 Aug 2020 13:38:19 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1918DC061575
        for <linux-spi@vger.kernel.org>; Wed,  5 Aug 2020 10:38:17 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id z14so11058012ljm.1
        for <linux-spi@vger.kernel.org>; Wed, 05 Aug 2020 10:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A675ThsP7PRE/BF9k2IR+DTA9dTewWA+3r+Q8rIgHHw=;
        b=Iunbr9TCGv23y2T1crUo6ZEK4F1RjPVR1c4x01v31LrpNYvSldJHc9NXwdY3N+Y2lR
         MmXjH/bT7RW5V/vKNYKrcCrq7cyd5bcRRrwdJ5E9OlLsy7XoRr1z8XbDQo1YryE8LoiU
         J2Uv3C1vSGwfwNtWUxlae4M5mj32JYNMCzsZo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A675ThsP7PRE/BF9k2IR+DTA9dTewWA+3r+Q8rIgHHw=;
        b=lQVf4fxMTpniMfORrZ7zYBFBWf5wPGvPHzeVEsJD/0nZS39ZdL/oGD5EIVPzteNg2B
         gt5LfCtmvIieqxOVwLtFPigUU3paWnDjyUnMtRicnSqdDgsFyo9m8milW/V6DRLsX2K5
         sL6cKQ5hkOTTLvvCscI9D4cj77Onbr8DU3m95Qcrfcyx7qc684TF6dCLv9WJo0DdiBSE
         aX7YGGLNLEtm/Z++dHsVeUezAQr6I7bt3wVNOrceozxMlYiaJQN45Z0LVA6asnaqiyYy
         xDGV48OSSzBUT/WdF/dxGHx8WFSQMhSfQ+PZ31BhybU340v0mAMtm5B8rVva4j3srNv2
         WAQA==
X-Gm-Message-State: AOAM530ETt1vJVgD3efGzyz8CYWQA22Wt3m/jRYtESz6TRW9CaGn6ZZp
        JnYiRUuj0Uq11sfG42IMNpfbvtUnzHc=
X-Google-Smtp-Source: ABdhPJxIxck7M9KFGM02aNcWdDGhFfjdBz2Ec7oVv/FsDPccknS0twFOk7UHPoHpq7FVvvz0opmKjw==
X-Received: by 2002:a2e:80d8:: with SMTP id r24mr1851848ljg.305.1596649095903;
        Wed, 05 Aug 2020 10:38:15 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id y26sm1156195ljm.132.2020.08.05.10.38.14
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Aug 2020 10:38:14 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id z14so11057869ljm.1
        for <linux-spi@vger.kernel.org>; Wed, 05 Aug 2020 10:38:14 -0700 (PDT)
X-Received: by 2002:a2e:b008:: with SMTP id y8mr1711869ljk.421.1596649093969;
 Wed, 05 Aug 2020 10:38:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200803124114.2B1812054F@mail.kernel.org> <159664879424.18421.2442649014891589713.pr-tracker-bot@kernel.org>
In-Reply-To: <159664879424.18421.2442649014891589713.pr-tracker-bot@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 5 Aug 2020 10:37:58 -0700
X-Gmail-Original-Message-ID: <CAHk-=whHhwoFva3PA=z0Kpy6aQA==jx9LYEp00BSEHUu0RD7QA@mail.gmail.com>
Message-ID: <CAHk-=whHhwoFva3PA=z0Kpy6aQA==jx9LYEp00BSEHUu0RD7QA@mail.gmail.com>
Subject: Re: [GIT PULL] SPI updates for v5.9
To:     pr-tracker-bot@kernel.org
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, Aug 5, 2020 at 10:33 AM <pr-tracker-bot@kernel.org> wrote:
>
> The pull request you sent on Mon, 03 Aug 2020 13:39:59 +0100:
>
> > https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-v5.9
>
> has been merged into torvalds/linux.git:

Strange timing for the pr-tracker-bot since I did that merge two days
ago, but the reason seems to be

 (a) I pushed out other changes, waking up pr-tracker-bot

 (b) pr-tracker-bot has moved to a new machine and picks up pull
requests from all the lore lists

 (c) the pull request went to linux-spi, which two days ago was _not_
tracked by pr-tracker-bot, so now it says "oh, new pull request
notification".

just in case anybody else reacted to the odd message out of the blue.

              Linus
