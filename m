Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5413C1FFD90
	for <lists+linux-spi@lfdr.de>; Thu, 18 Jun 2020 23:52:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728975AbgFRVwF (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 18 Jun 2020 17:52:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726573AbgFRVwE (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 18 Jun 2020 17:52:04 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE89DC06174E
        for <linux-spi@vger.kernel.org>; Thu, 18 Jun 2020 14:52:04 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id z63so3454186pfb.1
        for <linux-spi@vger.kernel.org>; Thu, 18 Jun 2020 14:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=htMPMcs32J6Mn8F4SKlfPg2WVumh2QnKtqfjwVVA/yY=;
        b=Hj2o2YVWPdtfsH2wb6VoOBekKUoiFrGd1yY6m8NmfE2/NmN+wsPKw+6XWLLdNIznui
         jE/kQOovXbAa/AHnD2YO0Y4ucvGrRQ3rYHJKgAs6tCqZmLSJQXMI6N3b9EqcCqCs8jpv
         v680OYeWSzhRO9BlqDtPgpKxU6daT6OLkO/Jg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=htMPMcs32J6Mn8F4SKlfPg2WVumh2QnKtqfjwVVA/yY=;
        b=sfIPdP5hWzS/HOR/3p1tHQWApBT4ne1xcAAjyg2OZnFHgAS39y1X1DH6VPePcjg6rD
         TlWI0CWI+jiTGHaVmao8VuHEaQxA+pHmSxkw/Cemby15ytWL2cPPLjrh3oQ4n0i1z/OB
         VNjwggX2ofTGRbAvbaXlaWQNsExXpng2QcS/JySuNDSW1cxsa/B0b7iAn4bAITUWl33A
         seomwsUqIdYEvvl17fC3LOj1d1cX/nw6N4UJ9NJnpLusG5oDeawHnvesnbCqFM+JMvX+
         0h4bHmxQgmroSGr6GHGRSUwgoXGc8Ae89twOwU97lRs721Esa/tkwjG5AbB97X8vjeSa
         82/g==
X-Gm-Message-State: AOAM530walIzU6x+iQhGkMNfs2hsQZn7sKCbRL2kTyzXtnbwxj+PSLX7
        ENezlMuh/q+pNLb04HQtZ+aOsw==
X-Google-Smtp-Source: ABdhPJz4ExoNuYi889lTqPTdupQ5+Uvgur4SUMgfRQnXy/W0tzn9UNT4NgtnDTXBH/XJOcVyLIErpA==
X-Received: by 2002:a62:1d8e:: with SMTP id d136mr5271301pfd.323.1592517123988;
        Thu, 18 Jun 2020 14:52:03 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id m7sm3335220pgg.69.2020.06.18.14.52.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 14:52:03 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAD=FV=Xh3+cROZC8dCn99MLkngsyBcxq+Gv1CERayZXExwdygA@mail.gmail.com>
References: <20200618150626.237027-1-dianders@chromium.org> <20200618080459.v4.5.Ib1e6855405fc9c99916ab7c7dee84d73a8bf3d68@changeid> <159250352382.62212.8085892973272354046@swboyd.mtv.corp.google.com> <CAD=FV=Xh3+cROZC8dCn99MLkngsyBcxq+Gv1CERayZXExwdygA@mail.gmail.com>
Subject: Re: [PATCH v4 5/5] spi: spi-geni-qcom: Don't keep a local state variable
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Alok Chauhan <alokc@codeaurora.org>, skakit@codeaurora.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>
To:     Doug Anderson <dianders@chromium.org>
Date:   Thu, 18 Jun 2020 14:52:02 -0700
Message-ID: <159251712230.62212.10744179843753723398@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Quoting Doug Anderson (2020-06-18 13:09:47)
> On Thu, Jun 18, 2020 at 11:05 AM Stephen Boyd <swboyd@chromium.org> wrote:
> >
> > Quoting Douglas Anderson (2020-06-18 08:06:26)
> > > @@ -126,20 +120,23 @@ static void handle_fifo_timeout(struct spi_mast=
er *spi,
> > >         struct geni_se *se =3D &mas->se;
> > >
> > >         spin_lock_irq(&mas->lock);
> > > -       reinit_completion(&mas->xfer_done);
> > > -       mas->cur_mcmd =3D CMD_CANCEL;
> > > -       geni_se_cancel_m_cmd(se);
> > > +       reinit_completion(&mas->cancel_done);
> > >         writel(0, se->base + SE_GENI_TX_WATERMARK_REG);
> > > +       mas->cur_xfer =3D NULL;
> >
> > BTW, is this necessary? It's subtlely placed here without a comment why.
>=20
> I believe so.  Now that we don't have the "cur_mcmd" we rely on
> cur_xfer being NULL to tell the difference between a "done" for chip
> select vs. a "done" for transfer.
>=20
> * When we start a transfer we set "cur_xfer" to a non-NULL pointer.
> When the transfer finishes we set it to NULL again.
>=20
> * When we start a chip select transfer we _don't_ explicitly set it to
> NULL because it should already be NULL.
>=20
> * When we are aborting a transfer we need to NULL so we can handle the
> chip select that will come next.
>=20
> I suppose it's possible that we could get by without without NULLing
> it because I believe when the "abort" IRQ finally fires then it will
> include a "DONE" and that would presumably NULL it out.  ...but I
> guess if both the cancel and abort timed out and no IRQ ever fired
> then nothing would have NULLed it and the next chip select would be
> confused.

I was going to say that we should set it NULL when starting CS but that
is not as important as clearing it out when a cancel/abort is processing
so that a stale transfer isn't kept around.

>=20
> Prior to getting rid of "cur_mcmd" this all wasn't needed because
> "cur_xfer" was only ever looked at if "cur_mcmd" was set to
> "CMD_XFER".
>=20
>=20
> One part of my change that is technically not related to the removal
> of "cur_mcmd" is the part where I do "mas->tx_rem_bytes =3D
> mas->rx_rem_bytes =3D 0;".  I can split that as a separate change if you
> want but it seemed fine to just clean up this extra bit of state here.
>=20

How about a comment like this?

-----8<----
diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index d8f03ffb8594..670f83793aa4 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -121,6 +121,10 @@ static void handle_fifo_timeout(struct spi_master *spi,
 	spin_lock_irq(&mas->lock);
 	reinit_completion(&mas->cancel_done);
 	writel(0, se->base + SE_GENI_TX_WATERMARK_REG);
+	/*
+	 * Make sure we don't finalize a spi transfer that timed out but
+	 * came in while cancelling.
+	 */
 	mas->cur_xfer =3D NULL;
 	mas->tx_rem_bytes =3D mas->rx_rem_bytes =3D 0;
 	geni_se_cancel_m_cmd(se);
