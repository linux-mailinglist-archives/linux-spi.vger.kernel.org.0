Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5CD616B234
	for <lists+linux-spi@lfdr.de>; Mon, 24 Feb 2020 22:28:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbgBXV2m (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 24 Feb 2020 16:28:42 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:34838 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727716AbgBXV2l (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 24 Feb 2020 16:28:41 -0500
Received: by mail-lj1-f193.google.com with SMTP id q8so11739573ljb.2
        for <linux-spi@vger.kernel.org>; Mon, 24 Feb 2020 13:28:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wMq54bZLHLBxwerxfl5UdZbeQNMpBUzRLZDC5/TbRIY=;
        b=ul+tuP8hNyxbq61sLOa5xbwQ7/XPUTNhLBUIsVq9THoGlu5au+JstGRYswaXd/MUTw
         hu9d5BAJPb4t+0cMGSZwpXvVh6Pey7rjt0uIgLftfaXUf66ZMhVvdPqDMUodI6W9/zce
         1Ago9YPv5KrEGabrnWcoa4YoekrXCq2VOt8t7hTf1vVpAmYaHShQjJPVmrLX2PyW24GM
         hL0R9NYz8TJbeJwoww5veP3k7M812CxhUm2IG0CJyX8lcmA/uvRYE9hLLIRaD3/Lx4Mq
         5oneJ47hRL2HUUltE44vFewYmAhzAXZNIb9C2vm7nz8eSn+Tbes3K+fpCtir3k677MW7
         iAJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wMq54bZLHLBxwerxfl5UdZbeQNMpBUzRLZDC5/TbRIY=;
        b=KPA8pQsgqCS2hFpBus8WwwBK1ROYAhF2gJ0+9wFondQEpPPa39GzxG+cVrDyIV8pRx
         P0Rou4VQTlSSKrzAumUCV9EvN+hUwpVtKBXJwf/YIU/JqUGTyxogGlS1JKstDxa2L3PX
         6BUzA0CmLlhqswFIZhs/tGWAzmG8AspHFEqjK56jlmjJ6J8x0hl94YkztgkbqPW28KYL
         lwCzS1OCgOKx4bw3NB5FgKHGTM/lAalVmJapggglBh8VINdCr0bizRqQ+bhNt2SHpaZJ
         TKuFWi7lcMYvi21xZ4MzJo9wx/Ml8Aqh/323JkqHzHrmgvJSPg2z4Aengl5y/X6mbQaG
         +8PA==
X-Gm-Message-State: APjAAAVpx6Okfd4SNhKhkb5qr7/G0ILtc8Scg6lpaX3yE4CznnH33qdD
        yWdw0wFVQ5NsqLB8KzuxNPnpho9T+WZSlZajzjCaBg==
X-Google-Smtp-Source: APXvYqyMq9T/Fn06rswpyz1B/AfyB+fUsnls6uep+5LChqSuZ6hFNZZLf/LdzRRYS6HbAYOSrOhxs7mPuYEtE8MwsxM=
X-Received: by 2002:a2e:e12:: with SMTP id 18mr32538691ljo.123.1582579718004;
 Mon, 24 Feb 2020 13:28:38 -0800 (PST)
MIME-Version: 1.0
References: <CB4ED07B85D6BB40B8B44F6D5442E4F6572C1523@BGSMSX101.gar.corp.intel.com>
In-Reply-To: <CB4ED07B85D6BB40B8B44F6D5442E4F6572C1523@BGSMSX101.gar.corp.intel.com>
From:   Evan Green <evgreen@google.com>
Date:   Mon, 24 Feb 2020 13:28:01 -0800
Message-ID: <CAE=gft5JOwvha6e0RC+6=e444QUxfYyjNs7uq=3bhHMwFmCfmw@mail.gmail.com>
Subject: Re: Re: [PATCH] spi: pxa2xx: Add CS control clock quirk
To:     "Srivastava, Shobhit" <shobhit.srivastava@intel.com>
Cc:     Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Rajat Jain <rajatja@google.com>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Mark Brown <broonie@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rajatxjain@gmail.com" <rajatxjain@gmail.com>,
        "Muthukrishnan, Porselvan" <porselvan.muthukrishnan@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

 0x

On Thu, Feb 13, 2020 at 8:57 AM Srivastava, Shobhit
<shobhit.srivastava@intel.com> wrote:
>
>
> > Hi
> >
> > + Andy
> >
> > On 2/12/20 12:34 AM, Rajat Jain wrote:
> > > From: Evan Green <evgreen@chromium.org>
> > >
> > > Date: Wed, 29 Jan 2020 13:54:16 -0800
> > > Subject: [PATCH] spi: pxa2xx: Add CS control clock quirk
> > >
> > This patch subject is missing from mail subject.
> >
> Added
>
> > > In some circumstances on Intel LPSS controllers, toggling the LPSS CS
> > > control register doesn't actually cause the CS line to toggle.
> > > This seems to be failure of dynamic clock gating that occurs after
> > > going through a suspend/resume transition, where the controller is
> > > sent through a reset transition. This ruins SPI transactions that
> > > either rely on delay_usecs, or toggle the CS line without sending
> > > data.
> > >
> > > Whenever CS is toggled, momentarily set the clock gating register to
> > > "Force On" to poke the controller into acting on CS.
> > >
> > Could you share the test case how to trigger this? What's the platform =
here?
> > I'd like to check does this reproduce on other Intel LPSS platforms so =
is there
> > need to add quirk for them too.
> >
> This is on a CometLake platform. We are probing the SPI_CS line on a scop=
e.
> Even though the writes to SPI_CS_CONTROL register are successful, it does=
n=E2=80=99t toggle the CS line.
> Hence checking on a scope is better.
>
> Easy way to test this is to program the cs control register via iotools a=
nd see if the CS line toggles.

Yes, as Shobhit says, this can be observed by watching the voltage of
the CS line during a SPI transaction with no data (but a delay set).
For us, this happens when we toggle the CS line to our security chip
as a way to wake it up before talking to it [1]:

/* Assert CS, wait 1 msec, deassert CS */
struct spi_transfer spi_cs_wake =3D { .delay_usecs =3D 1000 };
spi_sync_transfer(phy->spi_device, &spi_cs_wake, 1);

[1] https://chromium.googlesource.com/chromiumos/third_party/kernel/+/refs/=
heads/chromeos-4.19/drivers/char/tpm/cr50_spi.c#151

We're finding that the line does not in fact toggle in this
transaction, even though the register changes appear to stick.

> This has to be done after one cycle of S0ix.

I don't know about runtime S0ix, but for me this is more related to
runtime PM of the device. For instance, I do this to experiment:

# echo on > /sys/devices/pci0000\:00/0000\:00\:1e.2/power/control
# mem_read32 0xd1226224
0x00001003
# mem_write32 0xd1226224 0x1001 ## This write sticks in the register,
but CS doesn't toggle.
# mem_write32 0xd1226238 0x3 ## Force clock gating on
# mem_write32 0xd1226224 0x1001
# mem_write32 0xd1226224 0x1003 ## Now the writes will both stick and
make it to the CS line.

Interestingly, I can switch clock gating back to auto (0), and writes
continue to make it to the CS line until I re-enable runtime PM.

Shobhit submitted a patch here for the same bug:
https://patchwork.kernel.org/patch/11388471/

Interestingly, I notice that the effect seems the same: once you flip
the _SSE bit on, you can also flip it back off and writes will
continue to work until runtime PM is re-enabled.

I don't have the in-depth knowledge of how this controller works, but
my gut says my patch more accurately addresses the underlying problem
by briefly forcing the controller to clock, whereas the other patch
pokes the _SSE enable bit, which forces clocking more as a side
effect. Although, the fact that I can set clock gating back to auto
and things still work until the next runtime suspend makes me feel
like I don't fully understand the issue either. I'm hoping someone
with more internal knowledge can weigh in as to the right approach.

Andy, to answer your other question, I'm unsure whether or not this
needs a delay of a device clock cycle or two to be observed, though in
my experiments it seems like that's not needed. I'm also not sure if
this affects other LPSS blocks, though maybe SPI is special since it
has this externally observable but out-of-band CS line that's not
directly tied to the serial engine.
-Evan


>
> > > Signed-off-by: Evan Green <evgreen@chromium.org>
> > > Signed-off-by: Rajat Jain <rajatja@google.com>
> > > ---
> > >   drivers/spi/spi-pxa2xx.c | 23 +++++++++++++++++++++++
> > >   1 file changed, 23 insertions(+)
> > >
> > > diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c inde=
x
> > > 4c7a71f0fb3e..2e318158fca9 100644
> > > --- a/drivers/spi/spi-pxa2xx.c
> > > +++ b/drivers/spi/spi-pxa2xx.c
> > > @@ -70,6 +70,10 @@ MODULE_ALIAS("platform:pxa2xx-spi");
> > >   #define LPSS_CAPS_CS_EN_SHIFT                     9
> > >   #define LPSS_CAPS_CS_EN_MASK                      (0xf <<
> > LPSS_CAPS_CS_EN_SHIFT)
> > >
> > > +#define LPSS_PRIV_CLOCK_GATE 0x38
> > > +#define LPSS_PRIV_CLOCK_GATE_CLK_CTL_MASK 0x3 #define
> > > +LPSS_PRIV_CLOCK_GATE_CLK_CTL_FORCE_ON 0x3
> > > +
> > >   struct lpss_config {
> > >     /* LPSS offset from drv_data->ioaddr */
> > >     unsigned offset;
> > > @@ -86,6 +90,8 @@ struct lpss_config {
> > >     unsigned cs_sel_shift;
> > >     unsigned cs_sel_mask;
> > >     unsigned cs_num;
> > > +   /* Quirks */
> > > +   unsigned cs_clk_stays_gated : 1;
> > >   };
> > >
> > >   /* Keep these sorted with enum pxa_ssp_type */ @@ -156,6 +162,7 @@
> > > static const struct lpss_config lpss_platforms[] =3D {
> > >             .tx_threshold_hi =3D 56,
> > >             .cs_sel_shift =3D 8,
> > >             .cs_sel_mask =3D 3 << 8,
> > > +           .cs_clk_stays_gated =3D true,
> > >     },
> > >   };
> > >
> > > @@ -383,6 +390,22 @@ static void lpss_ssp_cs_control(struct spi_devic=
e
> > *spi, bool enable)
> > >     else
> > >             value |=3D LPSS_CS_CONTROL_CS_HIGH;
> > >     __lpss_ssp_write_priv(drv_data, config->reg_cs_ctrl, value);
> > > +   if (config->cs_clk_stays_gated) {
> > > +           u32 clkgate;
> > > +
> > > +           /*
> > > +            * Changing CS alone when dynamic clock gating is on won'=
t
> > > +            * actually flip CS at that time. This ruins SPI transfer=
s
> > > +            * that specify delays, or have no data. Toggle the clock=
 mode
> > > +            * to force on briefly to poke the CS pin to move.
> > > +            */
> > > +           clkgate =3D __lpss_ssp_read_priv(drv_data,
> > LPSS_PRIV_CLOCK_GATE);
> > > +           value =3D (clkgate & ~LPSS_PRIV_CLOCK_GATE_CLK_CTL_MASK)
> > |
> > > +                   LPSS_PRIV_CLOCK_GATE_CLK_CTL_FORCE_ON;
> > > +
> > > +           __lpss_ssp_write_priv(drv_data, LPSS_PRIV_CLOCK_GATE,
> > value);
> > > +           __lpss_ssp_write_priv(drv_data, LPSS_PRIV_CLOCK_GATE,
> > clkgate);
> > > +   }
> > >   }
> > >
> > I wonder is it enough to have this quick toggling only or is time or ac=
tually
> > number of clock cycles dependent? Now there is no delay between but I'm
> > thinking if it needs certain number cycles does this still work when us=
ing low
> > ssp_clk rates similar than in commit d0283eb2dbc1 ("spi:
> > pxa2xx: Add output control for multiple Intel LPSS chip selects").
> >
> > I'm thinking can this be done only once after resume and may other LPSS
> > blocks need the same? I.e. should this be done in drivers/mfd/intel-lps=
s.c?
> >
> This behavior is seen after S0ix resume, but it is not seen after S3 resu=
me.
> I am thinking that it happens because we are not enabling the SSP after r=
esume.
> It is deferred until we need to send data. By enabling the SSP in resume,=
 I don=E2=80=99t see the issue.
> For S3, I think BIOS re-enables the SSP in resume flow.
>
> > Jarkko
>
> Regards,
> Shobhit
