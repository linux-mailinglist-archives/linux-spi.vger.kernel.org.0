Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0DB70189683
	for <lists+linux-spi@lfdr.de>; Wed, 18 Mar 2020 09:04:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbgCRIES (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 18 Mar 2020 04:04:18 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42916 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727447AbgCRIEQ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 18 Mar 2020 04:04:16 -0400
Received: by mail-pf1-f195.google.com with SMTP id x2so13108188pfn.9
        for <linux-spi@vger.kernel.org>; Wed, 18 Mar 2020 01:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=i9oNBg/4XLM+F+yVGTcBqwqwo0pspxNABxXhhxd2JUk=;
        b=LLTlmXsp2gZ/KDu9+CTGrSb5HOdl+js0VBoHOB/qKv5Zc0lAoS3FojlNrMGoVkDP4S
         Q3idTHteyqHnSjzADi2Wz3OBfDmPjNPv1V3cRTZgzoBRG1qDKjWKC6T2FU8AIwYBGUKO
         04KczZh9QIXEyCqiY57UowVhmnLKL/pe61aMY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=i9oNBg/4XLM+F+yVGTcBqwqwo0pspxNABxXhhxd2JUk=;
        b=o4vUevDHPPexZaM+d2kZ4V2VGqJg+R/xGJ/TLVKQv914hGfFejLDuHj1XOfC9PZvxO
         xmXpmtGLE7pUnJMKwsAcdrQsObzRIiURD9i5lwzXQvrgJEC80gbvyRfMa/rWLDawyyyh
         du2FxFE9shr+KjSb2jP4HBijIj63kPv0WcPLmqzCqACHzFbz9u54V13GwlFiJYZNaL5t
         VKgvEolJ2P4w/QN4wo/LbsZDz0eYUstLFbZadEbjcfanGbpHyfsTeirZgtt8OZi0tctp
         2EQmMRy3j2vJcU83LoBPcfI0SQpX9s3klnw3Xy5BM/HbgfHCuTJEO0I9Pum+eerbrpTZ
         d39Q==
X-Gm-Message-State: ANhLgQ0C+eVb2o/bVP+7vJNRmku8dd0iTFhjkWtd6ukmds6mPw+4FVWs
        ZLAw5GdqzYUfm/CpvFomR5JaYQ==
X-Google-Smtp-Source: ADFU+vt1mUWCmfnFnh8KUVSNsWJjGuQ4ABfF9W6ocPPaVPAg6ZGgS1Kuer4KXf6DoPTRIFarmlQYyw==
X-Received: by 2002:a63:2cce:: with SMTP id s197mr3436410pgs.184.1584518654392;
        Wed, 18 Mar 2020 01:04:14 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id c62sm4833363pfc.136.2020.03.18.01.04.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 01:04:13 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAD=FV=U+c4GZU1p3xYT3t=0Q2cLFxoiM=vqc8SsxOKehxbZPXw@mail.gmail.com>
References: <20200317133653.v2.1.I752ebdcfd5e8bf0de06d66e767b8974932b3620e@changeid> <158448096503.88485.8894151453752608519@swboyd.mtv.corp.google.com> <CAD=FV=U+c4GZU1p3xYT3t=0Q2cLFxoiM=vqc8SsxOKehxbZPXw@mail.gmail.com>
Subject: Re: [PATCH v2] spi: spi-geni-qcom: Speculative fix of "nobody cared" about interrupt
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Alok Chauhan <alokc@codeaurora.org>, skakit@codeaurora.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Girish Mahadevan <girishm@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>
To:     Doug Anderson <dianders@chromium.org>
Date:   Wed, 18 Mar 2020 01:04:12 -0700
Message-ID: <158451865253.88485.11351400745937437114@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Quoting Doug Anderson (2020-03-17 15:08:45)
> Hi,
>=20
> On Tue, Mar 17, 2020 at 2:36 PM Stephen Boyd <swboyd@chromium.org> wrote:
> >
> > > Patch is marked "speculative" because I have no way to reproduce this
> > > problem, so I'm just hoping this fixes it.  Weakly ordered memory
> > > makes my brain hurt.
> >
> > It could be that. It could also be the poor design of geni_se_init() and
> > how it enables many interrupts that this driver doesn't look to handle?
> > Why do we allow the wrapper to enable all those bits in
> > M_COMMON_GENI_M_IRQ_EN and S_COMMON_GENI_S_IRQ_EN if nobody is going to
> > handle them?
>=20
> It is possible it's related to an interrupt that we don't handle.  Howeve=
r:
>=20
> * IMO having the locking in place is safer anyway.  At some point I
> read that advice that trying to reason about weakly ordered memory was
> simply too hard for the average person (even the average kernel
> developer).  In 99% of the cases you could just use a lock so it's
> super clear and the performance difference is near zero.
>=20
> * Most of the cases I saw of the "nobody cared" for geni-spi was on a
> mostly idle system (presumably still doing periodic SPI transactions
> to the EC, though).  It seems weird that one of these other interrupts
> would suddenly fire.  It seems more likely that we just happened to
> win a race of some sort.

Sure, I'm mostly interested in understanding what that race is. I think
it is something like cur_mcmd being stale when it's tested in the irq
handler because the IO access triggers the irq before mas->cur_mcmd can
be updated due to out of order execution. Nothing stops
spi_geni_set_cs() from being reordered like this, especially because
there isn't any sort of barrier besides the compiler barrier of asm
volatile inside geni_set_setup_m_cmd():

  CPU0 (device write overtakes CPU)  CPU1
  ----                               ----
  mas->cur_mcmd =3D CMD_NONE;
  geni_se_setup_m_cmd(...)
                                     geni_spi_isr()
				      <tests cur_mcmd and it's still NONE>
  mas->cur_mcmd =3D CMD_CS;

>=20
> If nothing else it will suddenly become very obvious after my patch
> lands because I'll print out the status.

Fair enough.

>=20
>=20
> That all being said if someone wants to submit a patch to clean up
> which interrupts are enabled I'd support it.

Great!

>=20
>=20
> > > @@ -151,16 +151,19 @@ static void spi_geni_set_cs(struct spi_device *=
slv, bool set_flag)
> > >         struct geni_se *se =3D &mas->se;
> > >         unsigned long time_left;
> > >
> > > -       reinit_completion(&mas->xfer_done);
> > >         pm_runtime_get_sync(mas->dev);
> > >         if (!(slv->mode & SPI_CS_HIGH))
> > >                 set_flag =3D !set_flag;
> > >
> > > +       spin_lock_irq(&mas->lock);
> >
> > Why is this spin_lock_irq() vs. spin_lock_irqsave()? This isn't possible
> > to be called from somewhere that hasn't changed irq flags?
>=20
> See below.
>=20
>=20
> > > +       reinit_completion(&mas->xfer_done);
> > > +
> > >         mas->cur_mcmd =3D CMD_CS;
> > >         if (set_flag)
> > >                 geni_se_setup_m_cmd(se, SPI_CS_ASSERT, 0);
> > >         else
> > >                 geni_se_setup_m_cmd(se, SPI_CS_DEASSERT, 0);
> > > +       spin_unlock_irq(&mas->lock);
> >
> > This will force on interrupts if they were masked.
>=20
> I'll change it if you want, but in this function there is already a
> call to "wait_for_completion_timeout".  That's not gonna be too happy
> if this function is ever called with interrupts already masked.  Also
> in this function is pm_runtime_get_sync() which in many cases will
> sleep (I think we'll end up in geni_se_clks_on() which calls
> clk_bulk_prepare_enable()).
>=20
> In cases where you know for sure that interrupts aren't masked,
> spin_lock_irq() and spin_unlock_irq() are fine and that's what they're
> for, no?
>=20
>=20
> > >         time_left =3D wait_for_completion_timeout(&mas->xfer_done, HZ=
);
> > >         if (!time_left)
> > > @@ -307,6 +310,8 @@ static void setup_fifo_xfer(struct spi_transfer *=
xfer,
> > >         u32 spi_tx_cfg, len;
> > >         struct geni_se *se =3D &mas->se;
> > >
> > > +       spin_lock_irq(&mas->lock);
>=20
> ...and just to answer the same question for here: setup_fifo_xfer() is
> called from spi_geni_transfer_one() which is our "transfer_one"
> function.  We don't happen to block anywhere in these functions, but
> I'm nearly certain you are allowed to block in them.  We actually
> return a positive number to indicate to the SPI core that we're not
> doing the blocking ourselves but since the SPI core can't know we were
> going to do that it has to assume we might block.

Sounds good to not use irq save/restore here. Thanks for confirming.

>=20
>=20
> > > @@ -478,13 +485,29 @@ static irqreturn_t geni_spi_isr(int irq, void *=
data)
> > >         struct geni_se *se =3D &mas->se;
> > >         u32 m_irq;
> > >         unsigned long flags;
> > > -
> > > -       if (mas->cur_mcmd =3D=3D CMD_NONE)
> > > -               return IRQ_NONE;
> > > +       irqreturn_t ret =3D IRQ_HANDLED;
> > >
> > >         spin_lock_irqsave(&mas->lock, flags);
>=20
> Ironically the above could probably just be "spin_lock" since this is
> our interrupt handler.  ;-)  I'll just leave it alone though since
> what's there now doesn't hurt.

Yes that's another thing that can be done.

>=20
>=20
> > >         m_irq =3D readl(se->base + SE_GENI_M_IRQ_STATUS);
> >
> > Does this read need to be inside the lock?
>=20
> Probably not.  Discussion below.
>=20
>=20
> > > +       /* Check for spurious interrupt */
> > > +       if (!m_irq) {
> > > +               ret =3D IRQ_NONE;
> > > +               goto exit;
> >
> > I ask because it could be simplified by reading the status and then
> > immediately returning IRQ_NONE if no bits are set without having to do
> > the lock/unlock dance. And does writing 0 to the irq clear register do
> > anything?
>=20
> Sure.  I'll move it if you want.  It felt nicer to just keep the whole
> thing under lock so I didn't have to think about whether it mattered.
> ...and anyone else looking at it didn't need to think about if it
> mattered, too.  It it is very easy to say that it doesn't _hurt_ to
> have it under lock other than having one extra memory read under lock.
> ...and presumably the case where the optimization matters is
> incredibly rare (a spurious interrupt) and we just spent a whole lot
> of cycles calling the interrupt handler to begin with for this
> spurious interrupt.
>=20
> I would have a hard time believing that a write of 0 to a "write 1 to
> clear" register would have any impact.  It would be a pretty bad
> hardware design...

This is a writel to a device so it may take some time for the memory
barrier to drain any other writes with the full memory barrier in there.
Not sure if we care about getting super high performance here but that's
a concern.

>=20
>=20
> So I guess in summary, I'm not planning to spin for any of these
> things unless you really insist or you say I'm wrong about something
> above or someone else says my opinions are the wrong opinions.
>=20

Why do we need such large locking areas? Why can't we remove the enum
software tracking stuff and look at mas->cur_xfer to figure out if a cs
change is happening or not? I suppose mas->cur_xfer could be stale, so
we need to make sure that is modified and checked under a lock, and then
mas->rx_rem_bytes/tx_rem_bytes also need to be under a lock because
they're modified inside and outside the irq handler, but otherwise I
don't see any need to hold the lock over the register reads/writes. Most
other things are synchronized with the completions or in higher layers
of the SPI core.

I do wonder if we need to hold the lock again when we update the rx/tx
remaining bytes counter but I can't convince myself that the irq can run
on another CPU in parallel with the CPU that ran the irq first. That
seems impossible given that the interrupt would have to come again and
the irq controller would need to send it to a different CPU at the same
time. We should only need to grab the lock to make sure that cur_xfer
and remaining bytes is published by the CPU triggering the rx/tx
transfers and then assume the irq handler code is synchronous with
itself.

------8<-----
diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index f0ca7f5ae714..ac7da801a63d 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -64,13 +64,6 @@
 #define TIMESTAMP_AFTER		BIT(3)
 #define POST_CMD_DELAY		BIT(4)
=20
-enum spi_m_cmd_opcode {
-	CMD_NONE,
-	CMD_XFER,
-	CMD_CS,
-	CMD_CANCEL,
-};
-
 struct spi_geni_master {
 	struct geni_se se;
 	struct device *dev;
@@ -84,8 +77,7 @@ struct spi_geni_master {
 	const struct spi_transfer *cur_xfer;
 	struct completion xfer_done;
 	unsigned int oversampling;
-	spinlock_t lock;
-	enum spi_m_cmd_opcode cur_mcmd;
+	spinlock_t lock; /* Protects cur_xfer, {tx,rx}_rem_bytes */
 	int irq;
 };
=20
@@ -123,23 +115,18 @@ static void handle_fifo_timeout(struct spi_master *sp=
i,
 				struct spi_message *msg)
 {
 	struct spi_geni_master *mas =3D spi_master_get_devdata(spi);
-	unsigned long time_left, flags;
+	unsigned long time_left;
 	struct geni_se *se =3D &mas->se;
=20
-	spin_lock_irqsave(&mas->lock, flags);
 	reinit_completion(&mas->xfer_done);
-	mas->cur_mcmd =3D CMD_CANCEL;
 	geni_se_cancel_m_cmd(se);
 	writel(0, se->base + SE_GENI_TX_WATERMARK_REG);
-	spin_unlock_irqrestore(&mas->lock, flags);
 	time_left =3D wait_for_completion_timeout(&mas->xfer_done, HZ);
 	if (time_left)
 		return;
=20
-	spin_lock_irqsave(&mas->lock, flags);
 	reinit_completion(&mas->xfer_done);
 	geni_se_abort_m_cmd(se);
-	spin_unlock_irqrestore(&mas->lock, flags);
 	time_left =3D wait_for_completion_timeout(&mas->xfer_done, HZ);
 	if (!time_left)
 		dev_err(mas->dev, "Failed to cancel/abort m_cmd\n");
@@ -157,7 +144,6 @@ static void spi_geni_set_cs(struct spi_device *slv, boo=
l set_flag)
 	if (!(slv->mode & SPI_CS_HIGH))
 		set_flag =3D !set_flag;
=20
-	mas->cur_mcmd =3D CMD_CS;
 	if (set_flag)
 		geni_se_setup_m_cmd(se, SPI_CS_ASSERT, 0);
 	else
@@ -307,6 +293,7 @@ static void setup_fifo_xfer(struct spi_transfer *xfer,
 	u32 m_cmd =3D 0;
 	u32 spi_tx_cfg, len;
 	struct geni_se *se =3D &mas->se;
+	unsigned int rx_len =3D 0, tx_len =3D 0;
=20
 	spi_tx_cfg =3D readl(se->base + SE_SPI_TRANS_CFG);
 	if (xfer->bits_per_word !=3D mas->cur_bits_per_word) {
@@ -339,14 +326,14 @@ static void setup_fifo_xfer(struct spi_transfer *xfer,
 		writel(m_clk_cfg, se->base + GENI_SER_M_CLK_CFG);
 	}
=20
-	mas->tx_rem_bytes =3D 0;
-	mas->rx_rem_bytes =3D 0;
-	if (xfer->tx_buf && xfer->rx_buf)
-		m_cmd =3D SPI_FULL_DUPLEX;
-	else if (xfer->tx_buf)
-		m_cmd =3D SPI_TX_ONLY;
-	else if (xfer->rx_buf)
-		m_cmd =3D SPI_RX_ONLY;
+	if (xfer->tx_buf) {
+		m_cmd |=3D SPI_TX_ONLY;
+		tx_len =3D xfer->len;
+	}
+	if (xfer->rx_buf) {
+		m_cmd |=3D SPI_RX_ONLY;
+		rx_len =3D xfer->len;
+	}
=20
 	spi_tx_cfg &=3D ~CS_TOGGLE;
=20
@@ -356,18 +343,17 @@ static void setup_fifo_xfer(struct spi_transfer *xfer,
 		len =3D xfer->len / (mas->cur_bits_per_word / BITS_PER_BYTE + 1);
 	len &=3D TRANS_LEN_MSK;
=20
+	spin_lock_irq(&mas->lock);
 	mas->cur_xfer =3D xfer;
-	if (m_cmd & SPI_TX_ONLY) {
-		mas->tx_rem_bytes =3D xfer->len;
-		writel(len, se->base + SE_SPI_TX_TRANS_LEN);
-	}
+	mas->tx_rem_bytes =3D tx_len;
+	mas->rx_rem_bytes =3D rx_len;
+	spin_unlock_irq(&mas->lock);
=20
-	if (m_cmd & SPI_RX_ONLY) {
+	if (m_cmd & SPI_TX_ONLY)
+		writel(len, se->base + SE_SPI_TX_TRANS_LEN);
+	if (m_cmd & SPI_RX_ONLY)
 		writel(len, se->base + SE_SPI_RX_TRANS_LEN);
-		mas->rx_rem_bytes =3D xfer->len;
-	}
 	writel(spi_tx_cfg, se->base + SE_SPI_TRANS_CFG);
-	mas->cur_mcmd =3D CMD_XFER;
 	geni_se_setup_m_cmd(se, m_cmd, FRAGMENTATION);
=20
 	/*
@@ -416,10 +402,12 @@ static void geni_spi_handle_tx(struct spi_geni_master=
 *mas)
 	unsigned int i =3D 0;
=20
 	max_bytes =3D (mas->tx_fifo_depth - mas->tx_wm) * bytes_per_fifo_word;
+	spin_lock(&mas->lock);
 	if (mas->tx_rem_bytes < max_bytes)
 		max_bytes =3D mas->tx_rem_bytes;
=20
 	tx_buf =3D mas->cur_xfer->tx_buf + mas->cur_xfer->len - mas->tx_rem_bytes;
+	spin_unlock(&mas->lock);
 	while (i < max_bytes) {
 		unsigned int j;
 		unsigned int bytes_to_write;
@@ -454,10 +442,13 @@ static void geni_spi_handle_rx(struct spi_geni_master=
 *mas)
 		if (rx_last_byte_valid && rx_last_byte_valid < 4)
 			rx_bytes -=3D bytes_per_fifo_word - rx_last_byte_valid;
 	}
+	spin_lock(&mas->lock);
 	if (mas->rx_rem_bytes < rx_bytes)
 		rx_bytes =3D mas->rx_rem_bytes;
=20
 	rx_buf =3D mas->cur_xfer->rx_buf + mas->cur_xfer->len - mas->rx_rem_bytes;
+	spin_unlock(&mas->lock);
+
 	while (i < rx_bytes) {
 		u32 fifo_word =3D 0;
 		u8 *fifo_byte =3D (u8 *)&fifo_word;
@@ -478,13 +469,11 @@ static irqreturn_t geni_spi_isr(int irq, void *data)
 	struct spi_geni_master *mas =3D spi_master_get_devdata(spi);
 	struct geni_se *se =3D &mas->se;
 	u32 m_irq;
-	unsigned long flags;
+	bool cs_change =3D false;
=20
-	if (mas->cur_mcmd =3D=3D CMD_NONE)
-		return IRQ_NONE;
-
-	spin_lock_irqsave(&mas->lock, flags);
 	m_irq =3D readl(se->base + SE_GENI_M_IRQ_STATUS);
+	if (!m_irq)
+		return IRQ_NONE;
=20
 	if ((m_irq & M_RX_FIFO_WATERMARK_EN) || (m_irq & M_RX_FIFO_LAST_EN))
 		geni_spi_handle_rx(mas);
@@ -493,39 +482,48 @@ static irqreturn_t geni_spi_isr(int irq, void *data)
 		geni_spi_handle_tx(mas);
=20
 	if (m_irq & M_CMD_DONE_EN) {
-		if (mas->cur_mcmd =3D=3D CMD_XFER)
+		spin_lock(&mas->lock);
+		if (mas->cur_xfer) {
 			spi_finalize_current_transfer(spi);
-		else if (mas->cur_mcmd =3D=3D CMD_CS)
-			complete(&mas->xfer_done);
-		mas->cur_mcmd =3D CMD_NONE;
-		/*
-		 * If this happens, then a CMD_DONE came before all the Tx
-		 * buffer bytes were sent out. This is unusual, log this
-		 * condition and disable the WM interrupt to prevent the
-		 * system from stalling due an interrupt storm.
-		 * If this happens when all Rx bytes haven't been received, log
-		 * the condition.
-		 * The only known time this can happen is if bits_per_word !=3D 8
-		 * and some registers that expect xfer lengths in num spi_words
-		 * weren't written correctly.
-		 */
-		if (mas->tx_rem_bytes) {
-			writel(0, se->base + SE_GENI_TX_WATERMARK_REG);
-			dev_err(mas->dev, "Premature done. tx_rem =3D %d bpw%d\n",
-				mas->tx_rem_bytes, mas->cur_bits_per_word);
+			mas->cur_xfer =3D NULL;
+			/*
+			 * If this happens, then a CMD_DONE came before all the
+			 * Tx buffer bytes were sent out. This is unusual, log
+			 * this condition and disable the WM interrupt to
+			 * prevent the system from stalling due an interrupt
+			 * storm.
+			 *
+			 * If this happens when all Rx bytes haven't been
+			 * received, log the condition.
+			 *
+			 * The only known time this can happen is if
+			 * bits_per_word !=3D 8 and some registers that expect
+			 * xfer lengths in num spi_words weren't written
+			 * correctly.
+			 */
+			if (mas->tx_rem_bytes) {
+				writel(0, se->base + SE_GENI_TX_WATERMARK_REG);
+				dev_err(mas->dev, "Premature done. tx_rem =3D %d bpw%d\n",
+					mas->tx_rem_bytes,
+					mas->cur_bits_per_word);
+			}
+			if (mas->rx_rem_bytes) {
+				dev_err(mas->dev, "Premature done. rx_rem =3D %d bpw%d\n",
+					mas->rx_rem_bytes,
+					mas->cur_bits_per_word);
+			}
+		} else {
+			cs_change =3D true;
 		}
-		if (mas->rx_rem_bytes)
-			dev_err(mas->dev, "Premature done. rx_rem =3D %d bpw%d\n",
-				mas->rx_rem_bytes, mas->cur_bits_per_word);
+		spin_unlock(&mas->lock);
 	}
=20
-	if ((m_irq & M_CMD_CANCEL_EN) || (m_irq & M_CMD_ABORT_EN)) {
-		mas->cur_mcmd =3D CMD_NONE;
+	/* Wake up spi_geni_set_cs() or handle_fifo_timeout() */
+	if (cs_change || (m_irq & M_CMD_CANCEL_EN) || (m_irq & M_CMD_ABORT_EN))
 		complete(&mas->xfer_done);
-	}
=20
 	writel(m_irq, se->base + SE_GENI_M_IRQ_CLEAR);
-	spin_unlock_irqrestore(&mas->lock, flags);
+
 	return IRQ_HANDLED;
 }
