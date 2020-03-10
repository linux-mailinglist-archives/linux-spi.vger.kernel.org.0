Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D310D1804B9
	for <lists+linux-spi@lfdr.de>; Tue, 10 Mar 2020 18:26:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726315AbgCJR0z (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 10 Mar 2020 13:26:55 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:43334 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726271AbgCJR0y (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 10 Mar 2020 13:26:54 -0400
Received: by mail-ed1-f67.google.com with SMTP id dc19so17298726edb.10;
        Tue, 10 Mar 2020 10:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=51/iVXd6ISvkUNu0+IDc5XrQpO90zZ0ET3uyxLtX7gU=;
        b=qIt3JtTiaBF2P+M2J5wtXKREG/ccCqxaB54KxKHOizt2egcN1UNIepk7yH3DT9yDVo
         gSHsUnZq8bgFNC9hIm0RF/v6yS0XcIKrj8HsEp7oXrXczVxgdZ/OVOX8gTA69SnNJ1zW
         s2rOIoKC3PPZlOrITSpKthCIbquL2kZ6xyNnemIb0TBzmEd+VHTHilNxENvQR2e+IzK8
         OmAQAhj3iELUDb8NuJbnUUDwGVkoKqwYLqQ2vWk1Q+TY5hRP4z4jX8uNKWCBu/2E9c7d
         8kT8T+O9TDTpgd/9O418JQ74Egn/W5FxC1OnjeLSPbN7Y8pBmDtOzYCwQmb+RNN1Ig+Q
         Il6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=51/iVXd6ISvkUNu0+IDc5XrQpO90zZ0ET3uyxLtX7gU=;
        b=Am0yOpSEhV9W1vcNtjCzrpyv/aH1xk+Unm4ygBBq/S4X25N22rNyDatnQHIGKaUT99
         MMI5pIZdyZi4x7KgLvtqosrBTiuKx1i9bdCjbF+GLbDt7JxdU33Fbt5LoTW+QstLQsI7
         v/V1308oTqDcrzGnNGw17Ms69eiLHLBmIm55/YAFSgGr9laS1X7s7+CgxCfB6+w/bRKo
         TXBQyfYWvYUwQ4nJE/NU4T+14vTntk/zuL4OJKs7fUb7iVBMvlSug2Pb0ttoOsP3lx0j
         9CywUGcFH824fRWqJWoCntZZAkv7VPEQCykYll/Hcku2BIwibwmqnP9JSqODk1VthOJ4
         l3KQ==
X-Gm-Message-State: ANhLgQ2obZm7pSPriaC40PwG+FPZtpeAb9RXHyjp2gWLfAaBMUy9kdAK
        2SiQOanUkC7jPZEU88PV7iC5v7R9nChleh0BXjk=
X-Google-Smtp-Source: ADFU+vsABVE27j6p2OgUMFvFjq0fMEEp1BSbONgFw4lfy/QP9JO2sfupKp+27ik6ft6S2g6xYrEWR3Dg1jIfOJccT6o=
X-Received: by 2002:a17:906:76c6:: with SMTP id q6mr19835693ejn.176.1583861212865;
 Tue, 10 Mar 2020 10:26:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200310073313.21277-1-michael@walle.cc> <4beb5200a76f2d817be7276444543de4@walle.cc>
 <ea6ffa30ddc2459d07935e5e61a41172@walle.cc> <CA+h21hqMoPhbq8YG0UeV1kP0iXApYsJvb9MZjPGX54dm2U-KnQ@mail.gmail.com>
 <76923af394f334337a3cac125c270087@walle.cc> <20200310171403.GL4106@sirena.org.uk>
In-Reply-To: <20200310171403.GL4106@sirena.org.uk>
From:   Vladimir Oltean <olteanv@gmail.com>
Date:   Tue, 10 Mar 2020 19:26:41 +0200
Message-ID: <CA+h21hqLxMREixud3Mh8p4q6J7rvJzRH+aFVgYLTZ9aNmkZBww@mail.gmail.com>
Subject: Re: [PATCH] spi: spi-fsl-dspi: fix DMA mapping
To:     Mark Brown <broonie@kernel.org>
Cc:     Michael Walle <michael@walle.cc>, linux-spi@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Vladimir Oltean <vladimir.oltean@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, 10 Mar 2020 at 19:14, Mark Brown <broonie@kernel.org> wrote:
>
> On Tue, Mar 10, 2020 at 03:12:45PM +0100, Michael Walle wrote:
> > Am 2020-03-10 14:02, schrieb Vladimir Oltean:
>
> > > I'm testing LS1028A with IOMMU_DEFAULT_PASSTHROUGH=y and I didn't have
> > > time to change my setup now. I've also sent a v3 to my patch series
> > > which is going to conflict with this one, sorry.
>
> > No worries, its easy enough to rebase.
>
> > > I would have picked
> > > your patch up with my series but I didn't have the right environment
> > > to test it.
>
> > I'll resend a v2 once your series is working.
>
> Since it looks like your series might need another spin anyway I'm
> thinking it's sensible to apply this now and you rebase instead?  Cuts
> down on the number of pending patches if nothing else (unless the
> testing stuff gets sorted out of course).

Sure, go ahead.

Thanks,
-Vladimir
