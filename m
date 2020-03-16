Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38358186FF4
	for <lists+linux-spi@lfdr.de>; Mon, 16 Mar 2020 17:24:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732088AbgCPQYC (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 16 Mar 2020 12:24:02 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:37729 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731864AbgCPQYC (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 16 Mar 2020 12:24:02 -0400
Received: by mail-ed1-f66.google.com with SMTP id b23so22743166edx.4;
        Mon, 16 Mar 2020 09:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ZJNcfL+20pcF/nwvNIBx1sW4o3Q2BCHfxBO+o2iJP1E=;
        b=TTIjqCxllK3X2lZBFPw7ICZwUlDRHxnHW7NjEPyP7bRYIrWRr4yeK7Ieugc+qaddT5
         meVtk6e5fE6pXDialkcLZ+3IJSUnPo9gOI1koNCijDivBt2EhV81Kh3bMXQ4PqXNwRbF
         8471GWlZw+jYl1IOjR0/BBScsAL6B1Gu850oaJfUv4UCh9+wnMeexpn0xaLvYVjzvc4O
         2k6DkgQ+mH0bCuIs1N51H9UMGqet8MVK9P7Mw9ov3Cpwdxku2WYkl7Jw9m4DlHVqDKjA
         s60LXh9QoOLGVcxPtLAR24/tMF6iXIR95Gx+5tyoUP82Oe4R/N7QHx2WIaMt3fWEaLib
         grZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZJNcfL+20pcF/nwvNIBx1sW4o3Q2BCHfxBO+o2iJP1E=;
        b=sbdhZIe3y6vP3I63LsmRZE+6+mIwcPptpvAyek7autDaabHiXd5xQxofqzgHuUXudC
         lNnntg6FesgbztxLV5bDAO3M0SF/vBL5SLNlC88c5aNMk0PTeeVsYYefH+ks4WSaMlQ5
         Am65fbSopII+krUdY//nM2L3zKDPitcD+E7kcq+XOPeefGduFN+MhkHkpPDsR6vEfhRH
         jyNR4949+O9KqqB/kHoUsJM0C64HPxIu8HRW68y7dilIl9Utas9LyUTF+6eDg19+Gj2l
         fqNT5TEl8oFvJOSai0Dx0Ur+Yz4ymWvnLbSdVoY6UUagY6lBJpQ5sVAJj2fdZshVp63a
         FCgQ==
X-Gm-Message-State: ANhLgQ1VBtyoXgmEU9j1XhP84fcHyoUIr8i++ng8mNHjXVQw1saqyDxp
        sjVm2Si8DVZ5IG7azlSbvMJaB44rHnSKHHy1Dr8=
X-Google-Smtp-Source: ADFU+vtMS9Vu9nfFyeRmHSBt293hXzPvslNsTBpvv+xVzxztZq0wa6f/b2eJoXA5f1LV5AowpMF8HiAFnKYGgv1mpuE=
X-Received: by 2002:a17:906:f49:: with SMTP id h9mr88017ejj.6.1584375840024;
 Mon, 16 Mar 2020 09:24:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200314224340.1544-1-olteanv@gmail.com> <20200314224340.1544-7-olteanv@gmail.com>
 <20200316122613.GE5010@sirena.org.uk> <CA+h21hqRV+HmAz4QGyH9ZtcFWzeCKczitcn+mfTdwAC7ZobdDw@mail.gmail.com>
 <20200316124945.GF5010@sirena.org.uk> <CA+h21hpoHGuDwpOqtWJFO7+0mQVUrmcBLW7nnGq6dt3QU5axfw@mail.gmail.com>
 <d05fda0e119405343e540b9768db534f@walle.cc>
In-Reply-To: <d05fda0e119405343e540b9768db534f@walle.cc>
From:   Vladimir Oltean <olteanv@gmail.com>
Date:   Mon, 16 Mar 2020 18:23:48 +0200
Message-ID: <CA+h21hqt7Xe1LrSDsCVS8zqunQp2tKGhmHDraMirxL595go4nA@mail.gmail.com>
Subject: Re: [PATCH v3 06/12] spi: spi-fsl-dspi: Replace interruptible wait
 queue with a simple completion
To:     Michael Walle <michael@walle.cc>
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, Esben Haabendal <eha@deif.com>,
        angelo@sysam.it, andrew.smirnov@gmail.com,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Wei Chen <weic@nvidia.com>, Mohamed Hosny <mhosny@nvidia.com>,
        peng.ma@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, 16 Mar 2020 at 15:25, Michael Walle <michael@walle.cc> wrote:
>
> Am 2020-03-16 14:00, schrieb Vladimir Oltean:
> > On Mon, 16 Mar 2020 at 14:49, Mark Brown <broonie@kernel.org> wrote:
> >>
> >> On Mon, Mar 16, 2020 at 02:29:09PM +0200, Vladimir Oltean wrote:
> >>
> >> > Correct, the real problem is that I forgot to add a Fixes: tag for
> >> > patch 5. I'll do that now.
> >>
> >> OK.  The series otherwise looked fine but I'll wait for testing.
> >> Michael, if there's issues remaining it might be good to get some
> >> Tested-bys for the patches prior to whatever's broken so we can get
> >> those fixes in (but obviously verifying that is work so only if you
> >> have time).
>
> I'm just about to test it. While my former "cat /dev/mtdN > /dev/null"
> is working. I had the impression that it was slower, so I tried to test
> it with dd now and a known chunk size.. only to find out that it is
> still not working:
>
> # dmesg|grep spi
> [    1.894891] spi-nor spi1.0: w25q128fw (16384 Kbytes)
> ..
> # time cat /dev/mtd0 > /dev/null
> real    0m 30.73s
> user    0m 0.00s
> sys     0m 1.02s
> # dd if=3D/dev/mtd0 of=3D/dev/null bs=3D64
> 262144+0 records in
> 262144+0 records out
> # dd if=3D/dev/mtd0 of=3D/dev/null bs=3D64
> 262144+0 records in
> 262144+0 records out
> # dd if=3D/dev/mtd0 of=3D/dev/null bs=3D64
> dd: /dev/mtd0: Input/output error

I don't really have a SPI flash connected to DSPI on any LS1028A board.
Is this DMA or XSPI mode?

>
> I also wanted to test how it behaves if there are multiple processes
> access the /dev/mtdN device. I haven't found the time to dig into
> the call chain if see if there is any locking. Because what happens
> if transfer_one_message() is called twice at the same time from two
> different processes?
>

There is a mutex on the SPI bus, and therefore all variants of the
.transfer() call are operating under this lock protection, which
simplifies things quite a bit.

> >
> > This time I verified with a protocol analyzer all transfer lengths
> > from 1 all the way to 256, with this script:
> >
> > #!/bin/bash
> >
> > buf=3D''
> >
> > for i in $(seq 0 255); do
> > =C2=BB       buf=3D"${buf}\x$(printf '%02x' ${i})"
> > =C2=BB       spidev_test --device /dev/spidev2.0 --bpw 8 --cpha --speed
> > 5000000 -p "${buf}"
> > done
> >
> > It looked fine as far as I could tell, and also the problems
> > surrounding Ctrl-C are no longer present. Nonetheless it would be good
> > if Michael could confirm, but I know that he's very busy too so it's
> > understandable if he can no longer spend time on this.
>
> I'm working on it ;)
>
> -michael

Thanks,
-Vladimir
