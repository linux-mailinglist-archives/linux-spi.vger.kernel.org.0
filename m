Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5235634DE12
	for <lists+linux-spi@lfdr.de>; Tue, 30 Mar 2021 04:13:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbhC3CNI (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 29 Mar 2021 22:13:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231244AbhC3CMs (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 29 Mar 2021 22:12:48 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B276C0613D8
        for <linux-spi@vger.kernel.org>; Mon, 29 Mar 2021 19:12:48 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id hq27so22371219ejc.9
        for <linux-spi@vger.kernel.org>; Mon, 29 Mar 2021 19:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9uqxowpZkJw+kuwjzD0uTSbsW3f2tDCU9RKvi2lVi7k=;
        b=NSOQpRq6WsIU2IEARAEG681bUJKLdRBSvihGBW8+vDY3QNI6ykoz6Lu5V+sPvB9xOV
         KNr/nl47UxYRLvoBZggjRlRKwGpMDsdNjs0jpvMHiTbVvUX8G+bP17q+sbyGErJhgUbL
         PpAe9mL8WEBwBvEXuvNq4Xe/PmycPbCaN7EGIz832KgcOsZnJYE3QT/9IkcVFB0FUezI
         9YINBeeHQ/t80yeU3TiIb9V868xXZ+d0iiZK9No6gp2pdgz34dW84wit5qZzooSLAIW3
         B0szg2plxGJkmEspTfYI85OvhyHFkWHejzKVt5pHW0WccR6uHWPsBRY4Wx2a0czwXUET
         B3hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9uqxowpZkJw+kuwjzD0uTSbsW3f2tDCU9RKvi2lVi7k=;
        b=Nff1c2BZYt1dIMgU1KzzABNjyhdPzenGkYw+m8ySi61DkGsvFfkncF3G5YgryRdfgq
         nOLv2kCwNSbk95cbpcKyzZk4RN/EvuALPCP0MFuwot5LKWw3liGKmnedey4OTI26r7Gb
         hSQRrk7PNhM3x7NFLIh93Te71/zOa9MtbV2im8gQBqysfMGbi7SzquDcRbMCqvzGTeyM
         AFP9qWox/GP4TscbH5ZXpyxr0U0EuEzXwJuYFGvT/uxe+ia5kJfVXOpbvtAJEdn9O6cr
         gyHLDYdkvg37kllVtMRIrWauQYXKcVYQWgip+8whKbejdM5DykKd5ZzLokPrKVdogBTA
         5qBQ==
X-Gm-Message-State: AOAM533vatgMsDMJBs123pPEnoPBveBtiy6+8zfP8qxsBntWqtT6V4O7
        1mlqqx79fn9Ldrooav9XFkEpni8dAITCsQwbhWsDLA==
X-Google-Smtp-Source: ABdhPJzNAVy9mcTp2mou2/gOFfzxffM9nOymAGcfBdgdn0QtqKpdoh3jjqSqF2VvxQlx2dzn3gX5U6Ms8pJ8x9oga9c=
X-Received: by 2002:a17:906:495a:: with SMTP id f26mr30501651ejt.271.1617070366693;
 Mon, 29 Mar 2021 19:12:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210329015938.20316-1-brad@pensando.io> <20210329015938.20316-11-brad@pensando.io>
 <20210329160052.GE5166@sirena.org.uk>
In-Reply-To: <20210329160052.GE5166@sirena.org.uk>
From:   Brad Larson <brad@pensando.io>
Date:   Mon, 29 Mar 2021 19:12:36 -0700
Message-ID: <CAK9rFnw7MhPzBLbwEGVmBS+0vBJ1QA2RVdZaQU-b_Xy6Pwrz0Q@mail.gmail.com>
Subject: Re: [PATCH v2 10/13] dt-bindings: spi: cadence-qspi: Add support for
 Pensando Elba SoC
To:     Mark Brown <broonie@kernel.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Olof Johansson <olof@lixom.net>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, Mar 29, 2021 at 9:01 AM Mark Brown <broonie@kernel.org> wrote:
>
> On Sun, Mar 28, 2021 at 06:59:35PM -0700, Brad Larson wrote:
> > Add new vendor Pensando Systems Elba SoC compatible
> > string and convert to json-schema.
>
> These are two unrelated changes and should be separate patches, again as
> covered in submitting-patches.rst.  It is generally better to do the
> changes adding new stuff first and then convert to YAML as the final
> patches as the series since there is often a delay on reviews of YAML
> conversions.

The initial patch set only changed the text file and a request was made
to convert to YAML.  I'll change this particular patch to modify just the
text file as before and then the convert to YAML with a later patch in the set.
