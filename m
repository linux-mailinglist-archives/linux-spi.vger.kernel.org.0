Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6BE439209A
	for <lists+linux-spi@lfdr.de>; Mon, 19 Aug 2019 11:44:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbfHSJoy (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 19 Aug 2019 05:44:54 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:33744 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726314AbfHSJox (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 19 Aug 2019 05:44:53 -0400
Received: by mail-ed1-f67.google.com with SMTP id s15so1086386edx.0
        for <linux-spi@vger.kernel.org>; Mon, 19 Aug 2019 02:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2QopxOVm7tkR78qJ4XpeXmCv7hDIrzsh0WCqhuGnRa4=;
        b=Un9Lbb7l4ir9ibjGPblKgeSvvdvjHRfLAF04v0wXcKCGttsAT5pIgl6lOVEkX9/7/R
         QYeQPY9paxDVgCN93FXrN/ObrZLJhsHJbqCE/1VA6v4PBVTqwwj9dciYvAmJGvTsyXdZ
         GljmMabwKyczlK3XQzgDz0k0/qJW4DYKG3JIHOdK7vVZ7/HFyq8KO2bz8AowEJDwHLKC
         qHbNx9SSkyqTBGcuFGNWdGeRiLU64bwp9BNYdnT9GbOD6PfKZfKCuNfqr2SCBpgYV+GZ
         UfGa/iiStsZJS4wTkL60AO7g/SfKwF+wOmNvn0H0qRrb1Cd4+iUYMw5v7gZmGGGgIRkc
         khHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2QopxOVm7tkR78qJ4XpeXmCv7hDIrzsh0WCqhuGnRa4=;
        b=B2awDdzinBqX/OAKrjKPL2o6cmmAsN0q5TxOryRKNvahbO1SlwztY4pW8Et2cc+7dq
         mWUzDH14g+VROagl+ZmpMypt0EH2O2hXRTFmygFwJPCk0b2hHnVvmqWbi5Kw9PRUAh/2
         7p0Fwrk5AaHlj2jn/kfAijazIJ+9hqcpCqKtc9hkfiTj59iujsBUvidYM/DUZpiWXYF3
         42mAD1qvgA3nz6AnvxqkEn9qI3IJdfcdSLAhHMQ+BPpGLhVxwGrCaHgG3DPsQM1TwSVr
         bHJKj9O2sk7VkUNkccNDvX49UEx7eStXsHMsffR5nMStljIic9aMGeRB1GlKstzWNqgv
         dmLg==
X-Gm-Message-State: APjAAAVipC4qikTZAzp0/cvMjHG1mi2kZHvBIxhGGH9oFMcv5ka7mw94
        2FIBpN6ePIjbLDlXRPqCoqssV33CuzkoiNNLxov2bw==
X-Google-Smtp-Source: APXvYqyrMcq9ITeQRY4Zngi2lzKCKXLJpXgkyw1DQHLGqamGsp0mGoRO62XF5ItUQd6mRWeRRgND0LkCxJxRDqzSlzE=
X-Received: by 2002:a50:9dc8:: with SMTP id l8mr24446807edk.108.1566207892082;
 Mon, 19 Aug 2019 02:44:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190818180115.31114-1-olteanv@gmail.com> <20190819093921.GA5563@sirena.co.uk>
In-Reply-To: <20190819093921.GA5563@sirena.co.uk>
From:   Vladimir Oltean <olteanv@gmail.com>
Date:   Mon, 19 Aug 2019 12:44:41 +0300
Message-ID: <CA+h21hqqnJsnWeW4kowPYyHTwt6LLTss1r5XZCPbj0WS=CxbWQ@mail.gmail.com>
Subject: Re: [PATCH spi for-5.4 00/14] NXP DSPI driver cleanup
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, 19 Aug 2019 at 12:39, Mark Brown <broonie@kernel.org> wrote:
>
> On Sun, Aug 18, 2019 at 09:01:01PM +0300, Vladimir Oltean wrote:
> > This patchset was broken out of the "Deterministic SPI latency on NXP
> > LS1021A-TSN board" series. It contains a few driver cleanups (mostly
> > cosmetic).
>
> Please don't include all the extra tags you've got in your subject
> lines.  In my inbox this series looks like:
>
>     790 N T 08/18 Vladimir Oltean ( 16K) =E2=94=9C=E2=94=80>[PATCH spi fo=
r-5.4 01/14] spi: spi-f
>
> so I can't tell what it's actually about just from looking at it.  Just
> [PATCH 01/14] would be enough, putting a target version in or versioning
> the patch series can be OK but you usually don't use a target version
> for -next and adding spi in there is redundant given that it's also in
> the changelog.

Ok, sorry, just wanted to be clear what tree and branch I'm sending
against, but apparently the end result is less clear than I wanted to.
Will correct next time.

Thanks,
-Vladimir
