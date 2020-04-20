Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E3D61B0F9C
	for <lists+linux-spi@lfdr.de>; Mon, 20 Apr 2020 17:13:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728237AbgDTPMg (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 20 Apr 2020 11:12:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726871AbgDTPMf (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 20 Apr 2020 11:12:35 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4511C061A0F;
        Mon, 20 Apr 2020 08:12:34 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id w6so5764697ilg.1;
        Mon, 20 Apr 2020 08:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1KANu4cUD65S82lmIiU07FeIllaQkhNpX/3s3IPgN3E=;
        b=RgDFb32KuNLLsna2y/5I+2tdw6jgmi60xwvuo7s1rSDaE/7w30gtcWsShaerB09w4m
         1YrgVlC4K7UV3jIfy/IckwYodny0QH0BAqqFhyYZJi0XCfugelfX2MxoMShXqKdWw4Lm
         4ma+xK9Cn6F0Hudx69m1Sub1EGdR7hP/4k7v///Q+u6yL1uoM+MzceMw7Opc1ody8izi
         kM/ctkn4CPaJuXDhGH9KY4Ls5LpjiQdghcg4EJ3LLUbHuP7GddectBN7nYYpfHt5fLxO
         LXK5GzQln+bSYXlFEc9wlyk6Qv4E+cIfWND/VxRF1T0B6+t9dJKV+MbD/vq5VJV0aYIj
         luZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1KANu4cUD65S82lmIiU07FeIllaQkhNpX/3s3IPgN3E=;
        b=Htc47bAuASVbzIEVlO9kltvrnjMH+j3lwjAH5mxTptj/Ja5hTr7MYmnR+rlkkmTSEZ
         9NztRsH5Gt3J6y3XW9538BtQiNp1G0PrjagwGGwaRzar6CXu0Z8DdQpWqYx9xOHeXRFH
         ch/8qGDnFs0bY3VqAyMs5nMCxBUz6Z9WmIZsRPCZSS5I7CRNzMUn2twljDnoXBJGowsY
         1/2Li+ykP/qGMT4sUSaVeMP5gqk2NJ0NmVWRiMub6aS6P3pX684O9F9IETf28wxdDmA8
         9725W1VhzdgvfnWrU78HNjDS1aJ9AeUtWmVti2jVq2NxOeNHLisIwckH25Pmu3pWIwue
         CErg==
X-Gm-Message-State: AGi0Pua1o8q9+syKclcqYBvn26gq4MBiM4q/x13l/49SZt/cJH0WNknS
        kwmTbRkD05m+vISqt006mtE3w0dDDmDCZmlxJL4=
X-Google-Smtp-Source: APiQypL2E1Y6m/iRXIttTCmhHlg64CrNNr4IVdxn0m3KXmrJwlEWOznwojod+3UwyRO0rYWdfr+1tjDqAQ3nBBsAuKU=
X-Received: by 2002:a92:5dca:: with SMTP id e71mr15507083ilg.34.1587395554381;
 Mon, 20 Apr 2020 08:12:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200419192339.32023-1-kdasu.kdev@gmail.com> <20200419192339.32023-4-kdasu.kdev@gmail.com>
 <63176468-53b6-c11a-9e33-2ca9dd06f7a3@gmail.com>
In-Reply-To: <63176468-53b6-c11a-9e33-2ca9dd06f7a3@gmail.com>
From:   Kamal Dasu <kdasu.kdev@gmail.com>
Date:   Mon, 20 Apr 2020 11:12:21 -0400
Message-ID: <CAC=U0a1mOWo3ucMJ7x5wuWQ44NRA2+Dj6fKAi1dbevNaxcYJzA@mail.gmail.com>
Subject: Re: [Patch v2 3/9] spi: bcm-qspi: Handle lack of MSPI_REV offset
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Yes missed this one.
Should I send a v3 of the entire set.

Kamal

On Sun, Apr 19, 2020 at 3:44 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
>
> Hi Kamal,
>
> On 4/19/2020 12:23 PM, Kamal Dasu wrote:
> > Older MIPS chips have a QSPI/MSPI controller that does not have the
> > MSPI_REV offset, reading from that offset will cause a bus error. Match
> > their compatible string and do not perform a read from that register in
> > that case.
> >
> > Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> > Signed-off-by: Kamal Dasu <kdasu.kdev@gmail.com>
>
> This patch should also have a From: that is from me.
> --
> Florian
