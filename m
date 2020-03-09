Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8563A17E780
	for <lists+linux-spi@lfdr.de>; Mon,  9 Mar 2020 19:50:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727412AbgCISuu (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 9 Mar 2020 14:50:50 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:34339 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727334AbgCISut (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 9 Mar 2020 14:50:49 -0400
Received: by mail-ed1-f65.google.com with SMTP id c21so13276025edt.1;
        Mon, 09 Mar 2020 11:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/xfK+6B9GgktOd4QAvIfaiRVFeF6Yy/6P4gRBOJz6Jk=;
        b=BuXaDMqxOY5cZiRqst6Eg2nUc/SMwVspp0e8SpLgOtyAtLwc8QBcSOGut9W8DlI3MF
         gN30T0l3lqCG7u3kxIgiq7ITuWnu2/xxS6ABdyrvSJSHC0y/0VD9L2RngW3F1TQotjNg
         hOFmdporU7526cqMdLZ9wi/1DLJnYxpk/QtEIL8Emp69m33fActqpj2Wuy+QUPCU4bwG
         KghvS40vLUcLN9/bu+hTbFJLSwV0AAN8ezbyjtrpnn9xW2+IXAUzanWVTl3KJdWt/Xj/
         0umwWGWpBcYnzb6nFQN5ya+uZeIAm316A+ebgdNUVEnccyEpcLfnQMmpTcOsIzbE1KR7
         78GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/xfK+6B9GgktOd4QAvIfaiRVFeF6Yy/6P4gRBOJz6Jk=;
        b=BLPt9Tuu1aud22DwFKSignZ9FTpmZtD1bZyRAfYOvMbSCJjFVCtL/qRTLh2+U8rVOW
         8RkdDCi0ZYLtLZZgCCgtDUSIiC0BRDCsNiv273XWb5PcUAHPr483rErJC9t4UtsErMfG
         oyi+o5K6cPbu7n75vQESrwOTM4Ll40CXFe9zRCob+hWji6gsZUZFDHf20ruRaqEYXILv
         /d5wCyIFLnpWwyUwuKUuXsuQjNNYb3RBTwqbhUuIUzwdiv1EtvFASnXoEt5Yblo+4RZ7
         AGPCi+q/BK138l4uO8OcNnRfWeB4HaZwCK3GB8+bkwEb3BJg+gf6ZEqG8hrEeMVc81Ad
         w7bQ==
X-Gm-Message-State: ANhLgQ0WrcZv9HHvROJ+dv+BAnnxtv6xcREGkDLAdvRK2fmSOmrA6XzM
        rQoD/sjcsTzA0vFl7tH5shjffGLiqju1YuHnOKg=
X-Google-Smtp-Source: ADFU+vssDbKpyYTB6G50aADPJkJHC6Lziczxie8Ijt2LaoWXikyy3y5tBPojHrHVibUsMhIM7hMFP3Ws5Ee2XMhxpmI=
X-Received: by 2002:a50:9b07:: with SMTP id o7mr18048658edi.139.1583779847412;
 Mon, 09 Mar 2020 11:50:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200309145624.10026-1-olteanv@gmail.com> <20200309145624.10026-7-olteanv@gmail.com>
 <f213388d924b63d0fe265a2d731647be@walle.cc>
In-Reply-To: <f213388d924b63d0fe265a2d731647be@walle.cc>
From:   Vladimir Oltean <olteanv@gmail.com>
Date:   Mon, 9 Mar 2020 20:50:36 +0200
Message-ID: <CA+h21hqOhM9+k9cKXoA8coYpxNFWpgD+FjETeB6uWLbsfrx0uw@mail.gmail.com>
Subject: Re: [PATCH 6/6] arm64: dts: ls1028a-rdb: Add a spidev node for the mikroBUS
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
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, 9 Mar 2020 at 20:35, Michael Walle <michael@walle.cc> wrote:
>
> Am 2020-03-09 15:56, schrieb Vladimir Oltean:
> > From: Vladimir Oltean <vladimir.oltean@nxp.com>
> >
> > For debugging, it is useful to have access to the DSPI controller
> > signals. On the reference design board, these are exported to either
> > the
> > mikroBUS1 or mikroBUS2 connector (according to the CPLD register
> > BRDCFG3[SPI3]).
> >
> > Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> > ---
> >  arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
> > b/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
> > index bb7ba3bcbe56..43f403b30dae 100644
> > --- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
> > +++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
> > @@ -83,6 +83,20 @@
> >       };
> >  };
> >
> > +&dspi2 {
> > +     bus-num = <2>;
> > +     status = "okay";
> > +
> > +     /* mikroBUS1 */
> > +     spidev@0 {
> > +             compatible = "spidev";
>
> As far as I know this throws a warning at boot that you
> shouldn't use the compatible = "spidev", doesn't it?
>
> /*
>   * spidev should never be referenced in DT without a specific
>   * compatible string, it is a Linux implementation thing
>   * rather than a description of the hardware.
>   */
>

If this is supposed to mean that the "spidev" string is less
adequate/expressive than "rohm,dh2228fv", then ok, I'll use that.

> -michael
>
> > +             reg = <0>;
> > +             spi-max-frequency = <20000000>;
> > +             fsl,spi-cs-sck-delay = <100>;
> > +             fsl,spi-sck-cs-delay = <100>;
> > +     };
> > +};
> > +
> >  &esdhc {
> >       sd-uhs-sdr104;
> >       sd-uhs-sdr50;
