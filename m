Return-Path: <linux-spi+bounces-7249-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18E3AA6A742
	for <lists+linux-spi@lfdr.de>; Thu, 20 Mar 2025 14:36:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6333888140F
	for <lists+linux-spi@lfdr.de>; Thu, 20 Mar 2025 13:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1670C1C5D7E;
	Thu, 20 Mar 2025 13:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="LUwUCYap";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="56E+1zhf"
X-Original-To: linux-spi@vger.kernel.org
Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B34823C9;
	Thu, 20 Mar 2025 13:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742477768; cv=none; b=gbNENbCIM4aCDfQqKNNo6m0RPrnuSntqmIcs7cRBYf4XN+fzke/vbknrSzhh/227eq1gG5Ne5hKzBVwehDXC7oyPh3ZlgZ/HDhMQ4I49+nqHOZ4uOGG9rR8HtoSb8sqc3Q2OaFJmwRwm3eizxEU1nsgaTb3190zMAF6h39V/QdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742477768; c=relaxed/simple;
	bh=9hC2lrxOCVfeOv+2gpOJ5k1ux31w6sObpl2j3E5N0qk=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=HOU0uwqTT0gh04e/Y+uq/jADd2zcrh4xxeH5QFsktAXE5tAaKVEUOMMM5qAZIDKPaa1rqFLdpHi1OrDW8tXg6lKy6WAXNsBHkzFHw2iJOXAr5Yi/yMOad0x+J9cn1eGFRqKN7brbwdOC3kO5jmUHr/IpfbvqQeEaQ8NzG+9WM40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=LUwUCYap; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=56E+1zhf; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id 6CAE811401DD;
	Thu, 20 Mar 2025 09:36:03 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-07.internal (MEProxy); Thu, 20 Mar 2025 09:36:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1742477763;
	 x=1742564163; bh=UBlQakbweTv1Ll5BE/MHmsqvrqr8HkMle+NSlnyEDms=; b=
	LUwUCYapPnvbQ+UjP5Gb42lzjWFYxYd64GrlC5S5GYfJb2O/IfwE9L38HzCyO5ix
	pF5k3YGETKkBvEDsprG5Uhza5MnMuahCKPg6IMGXq6jEGc9As/BRS0Pjd5b6qG8K
	5Hre3S1d2vuiuisqjJ+WWmMHjoSmk2EZRb6hreqZZgFy7xA5DNzIxL9DIHNM8Gxy
	uT8Byc/eDLKSIlQLnZFNoGow2MFcK0kYn7W029ppiNJ/K8cFP3ZSBsX+vucSiT4G
	1uHopKQNE7tRh49QXfe6n8TqXW0zjfq9M93J1lC5p+4qQRw7Pdl7BOTxfEfBKyNv
	OQhGrlww69TOg/u8Z3dFPg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1742477763; x=
	1742564163; bh=UBlQakbweTv1Ll5BE/MHmsqvrqr8HkMle+NSlnyEDms=; b=5
	6E+1zhf79im8iQeKiSl6QCBwhbiuPQ8k06XfulVvyIt/WuXRDu5K+5hNmhCXoqpR
	OD6J1Qjt9tkKP78c6Tz+jrVVUi3WvN8vs0WoFsEWxlH4ygSLrCQXDDI5eP2sNPlV
	yQVn6WYWoMlhVPIm/AFGGaBR+4mm6+AIA+p/vGy/01cp+qfsC4ptbm50TnkOIlU0
	Am5f8fO86F7wuZ1vfMmRQydjLIOlVW8/sm83JWYpuzuwXujUo0vECem8ZKa42ZqS
	VHFSBVsAVm3gWcy9QcSi4vXbcH2o7MLU55JucboEy0N7/rjRc013orpuWb/tkpL9
	jcS65ug2Z1rdIp9Y5w+cw==
X-ME-Sender: <xms:whncZ9uW1PfvTDSvb3bkZp8KLd4zVy9EAwyPgvBhMkLc-BAxnFrMYA>
    <xme:whncZ2cZ58hmow9n5Kt6U-lsI4hwF0c4ahTNqzILhYMRVtu8yakwKwNckl-sLfrr7
    5XxxJTwH6FYlRDKTzU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugeekfeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertder
    tddtnecuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnug
    gsrdguvgeqnecuggftrfgrthhtvghrnhepheevfeetfffgtdfgueeggfefledtudevgfef
    hfdujedtgfefhfffudektdetiefhnecuffhomhgrihhnpegshihtvghsrdgurghtrgenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnuges
    rghrnhgusgdruggvpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprh
    gtphhtthhopegsrhhoohhnihgvsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehgrhgr
    nhhtrdhlihhkvghlhiesshgvtghrvghtlhgrsgdrtggrpdhrtghpthhtohepphhtvghsrg
    hrihhksehsuhhsvgdrtghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhsphhisehvghgvrh
    drkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:whncZwyzjN-hprsiVWCUmtCXN-G8jB6bcs3yQaeaSlHRZVP8M-GNLw>
    <xmx:whncZ0NwuFMx71wewxoWyTQhPGx5pEgDrYhAHeu44Hs0y0zzr4vhhA>
    <xmx:whncZ9_Cay60fazmlI24TvMEzm1-AbE_kAeCyhHw55jZZPeooJaoAQ>
    <xmx:whncZ0XvcB0nqEcM-rI-_B1d71rzw8Ai8lQEOrjixe74xPzpy1FcHA>
    <xmx:wxncZ5Z0Cr4mINGKwmLlONjdA5CXxK3sek97SiztOFP1K0enaX8Wc-Nc>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id D0A682220072; Thu, 20 Mar 2025 09:36:02 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T6af0c8f44e761c09
Date: Thu, 20 Mar 2025 14:35:41 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Mark Brown" <broonie@kernel.org>, "Petr Tesarik" <ptesarik@suse.com>
Cc: "Grant Likely" <grant.likely@secretlab.ca>, linux-kernel@vger.kernel.org,
 linux-spi@vger.kernel.org
Message-Id: <b37480a4-5344-4cf4-8fd1-400e2588fc28@app.fastmail.com>
In-Reply-To: <ca70e24d-57b6-4250-bd0d-7f5c72e1d282@sirena.org.uk>
References: 
 <1359268504-24937-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <20130205142128.2E28D3E1265@localhost>
 <20250320124330.480d652d@mordecai.tesarici.cz>
 <ca70e24d-57b6-4250-bd0d-7f5c72e1d282@sirena.org.uk>
Subject: Re: [PATCH] spi: Ensure memory used for spi_write_then_read() is DMA safe
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Mar 20, 2025, at 13:29, Mark Brown wrote:
> On Thu, Mar 20, 2025 at 12:43:30PM +0100, Petr Tesarik wrote:
>> Grant Likely <grant.likely@secretlab.ca> wrote:
>> > On Sun, 27 Jan 2013 14:35:04 +0800, Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:
>
>> > > Use GFP_DMA in order to ensure that the memory we allocate for transfers
>> > > in spi_write_then_read() can be DMAed. On most platforms this will have
>> > > no effect.
>
>> > Applied, thanks.
>
>> I'm sorry to revive such an old thread, but I'm trying to clean up DMA
>> zone use in preparation of killing the need for that zone entirely, and
>> this use looks fishy to me. I'm curious if it solves a real-world issue.
>
> Copying in Arnd who was muttering about this stuff the other day.  Since
> the original patch was over a decade ago I have absolutely no
> recollection of the circumstances around the change.  I imagine I was
> running into issues on some customer platform.

Thanks for adding me!

>> Second, this code path is taken only if transfer size is greater than
>> SPI_BUFSIZ, or if there is contention over the pre-allocated buffer,
>> which is initialized in spi_init() without GFP_DMA:
>
>> 	buf = kmalloc(SPI_BUFSIZ, GFP_KERNEL);
>
>> IIUC most transfers use this buffer, and they have apparently worked
>> fine for the last 10+ years...
>
> On a lot of systems most transfers are short and won't be DMAed at all
> since PIO ends up being more efficient, and most hardware is perfectly
> happy to DMA to/from wherever so *shrug*.  SPI_BUFSIZ is a maximum of 32
> bytes which is going to be under the copybreak limit for quite a few
> controllers, though admittedly 16 is also a popular number, so a lot of
> the time we don't actually DMA out of it at all.

I saw the same thing looked at it the other day and got confused
about why 'local_buf' is allocated with GFP_DMA and 'buf'
uses plain GFP_KERNEL when they are both used in the same place.

It also seems that the copy happens in the regmap_bulk_read()
path but not the regmap_bulk_write(), which just passes down
the original buffer without copying, as far as I can tell.

>> What about reverting commit 2cd94c8a1b41 ("spi: Ensure memory used for
>> spi_write_then_read() is DMA safe"), unless you have strong evidence
>> that it is needed?
>
> The whole goal there is to try to avoid triggering another copy to do
> the DMA so just reverting rather than replacing with some other
> construct that achieves the same goal doesn't seem great.  I think
> possibly we should just not do the copy at all any more and trust the
> core to DTRT with any buffers that are passed in, I think we've got
> enough stuff in the core though I can't remember if it'll copy with
> things allocated on the stack well.  I'd need to page the status back
> in.

From what I found, there are two scenarios that may depend on
GFP_DMA today:

 a) a performance optimization where allocating from GFP_DMA avoids
    the swiotlb bounce buffering. This would be the normal case on
    any 64-bit machine with more than 4GB of RAM and an SPI
    controller with a 32-bit DMA mask.
 b) An SPI controller on a 32-bit machine without swiotlb and an
    effective DMA mask that covers less than the lowmem area.
    E.g. on Raspberry Pi 4, the brcm,bcm2835-spi lives on a
    bus with an 1GB dma-ranges translation, but there may be more
    than 1GB of lowmem with CONFIG_VMSPLIT_2G=y and CONFIG_SWIOTLB=n.
    Without GFP_DMA that would just end up causing data corruption.

I've started playing around with a patch that annotates all
kmalloc(..., GFP_DMA) users that use buffers for SPI transfers,
as opposed to those that do it for another reason (ISA driver,
odd DMA mask, ...). There are probably some missing below, and some
of the regmap users are likely not SPI but something else, but
overall there are not a lot of them.

I think we have some corner cases where a driver allocates
a GFP_DMA buffer, calls spi_write_then_read through regmap,
which copies the data to the non-GFP_DMA global buffer,
and then the SPI controller driver calls dma_map_single()
on that, ending up with a third bounce buffer from
swiotlb.

I don't know what a good replacement interface would be, but
ideally there should never be more than one copy here,
which means that any temporary buffer would need to be
allocated according to the dma_mask of the underlying
bus master (dmaengine, spi controller, ...).

      Arnd

diff --git a/drivers/firmware/cirrus/cs_dsp.c b/drivers/firmware/cirrus/cs_dsp.c
index 42433c19eb30..10611858bef6 100644
--- a/drivers/firmware/cirrus/cs_dsp.c
+++ b/drivers/firmware/cirrus/cs_dsp.c
@@ -763,7 +763,7 @@ static int cs_dsp_coeff_write_ctrl_raw(struct cs_dsp_coeff_ctl *ctl,
 	if (ret)
 		return ret;
 
-	scratch = kmemdup(buf, len, GFP_KERNEL | GFP_DMA);
+	scratch = kmemdup(buf, len, GFP_KERNEL | GFP_SPI_DMA);
 	if (!scratch)
 		return -ENOMEM;
 
@@ -868,7 +868,7 @@ static int cs_dsp_coeff_read_ctrl_raw(struct cs_dsp_coeff_ctl *ctl,
 	if (ret)
 		return ret;
 
-	scratch = kmalloc(len, GFP_KERNEL | GFP_DMA);
+	scratch = kmalloc(len, GFP_KERNEL | GFP_SPI_DMA);
 	if (!scratch)
 		return -ENOMEM;
 
@@ -1724,7 +1724,7 @@ static void *cs_dsp_read_algs(struct cs_dsp *dsp, size_t n_algs,
 	/* Convert length from DSP words to bytes */
 	len *= sizeof(u32);
 
-	alg = kzalloc(len, GFP_KERNEL | GFP_DMA);
+	alg = kzalloc(len, GFP_KERNEL | GFP_SPI_DMA);
 	if (!alg)
 		return ERR_PTR(-ENOMEM);
 
diff --git a/drivers/iio/common/ssp_sensors/ssp_iio.c b/drivers/iio/common/ssp_sensors/ssp_iio.c
index 78ac689de2fe..246d03187b54 100644
--- a/drivers/iio/common/ssp_sensors/ssp_iio.c
+++ b/drivers/iio/common/ssp_sensors/ssp_iio.c
@@ -27,7 +27,7 @@ int ssp_common_buffer_postenable(struct iio_dev *indio_dev)
 	/* the allocation is made in post because scan size is known in this
 	 * moment
 	 * */
-	spd->buffer = kmalloc(indio_dev->scan_bytes, GFP_KERNEL | GFP_DMA);
+	spd->buffer = kmalloc(indio_dev->scan_bytes, GFP_KERNEL | GFP_SPI_DMA);
 	if (!spd->buffer)
 		return -ENOMEM;
 
diff --git a/drivers/iio/common/ssp_sensors/ssp_spi.c b/drivers/iio/common/ssp_sensors/ssp_spi.c
index f32b04b63ea1..b70dd891801f 100644
--- a/drivers/iio/common/ssp_sensors/ssp_spi.c
+++ b/drivers/iio/common/ssp_sensors/ssp_spi.c
@@ -87,7 +87,7 @@ static struct ssp_msg *ssp_create_msg(u8 cmd, u16 len, u16 opt, u32 data)
 	h.data = cpu_to_le32(data);
 
 	msg->buffer = kzalloc(SSP_HEADER_SIZE_ALIGNED + len,
-			      GFP_KERNEL | GFP_DMA);
+			      GFP_KERNEL | GFP_SPI_DMA);
 	if (!msg->buffer) {
 		kfree(msg);
 		return NULL;
@@ -375,7 +375,7 @@ int ssp_irq_msg(struct ssp_data *data)
 			 * but the slave should not send such ones - it is to
 			 * check but let's handle this
 			 */
-			buffer = kmalloc(length, GFP_KERNEL | GFP_DMA);
+			buffer = kmalloc(length, GFP_KERNEL | GFP_SPI_DMA);
 			if (!buffer) {
 				ret = -ENOMEM;
 				goto _unlock;
@@ -420,7 +420,7 @@ int ssp_irq_msg(struct ssp_data *data)
 		mutex_unlock(&data->pending_lock);
 		break;
 	case SSP_HUB2AP_WRITE:
-		buffer = kzalloc(length, GFP_KERNEL | GFP_DMA);
+		buffer = kzalloc(length, GFP_KERNEL | GFP_SPI_DMA);
 		if (!buffer)
 			return -ENOMEM;
 
diff --git a/drivers/input/rmi4/rmi_spi.c b/drivers/input/rmi4/rmi_spi.c
index 9d92129aa432..a9abc021bfad 100644
--- a/drivers/input/rmi4/rmi_spi.c
+++ b/drivers/input/rmi4/rmi_spi.c
@@ -67,7 +67,7 @@ static int rmi_spi_manage_pools(struct rmi_spi_xport *rmi_spi, int len)
 
 	tmp = rmi_spi->rx_buf;
 	buf = devm_kcalloc(&spi->dev, buf_size, 2,
-				GFP_KERNEL | GFP_DMA);
+				GFP_KERNEL | GFP_SPI_DMA);
 	if (!buf)
 		return -ENOMEM;
 
diff --git a/drivers/media/spi/cxd2880-spi.c b/drivers/media/spi/cxd2880-spi.c
index 65fa7f857fca..7063d46c4166 100644
--- a/drivers/media/spi/cxd2880-spi.c
+++ b/drivers/media/spi/cxd2880-spi.c
@@ -389,7 +389,7 @@ static int cxd2880_start_feed(struct dvb_demux_feed *feed)
 	if (dvb_spi->feed_count == 0) {
 		dvb_spi->ts_buf =
 			kzalloc(MAX_TRANS_PKT * 188,
-				GFP_KERNEL | GFP_DMA);
+				GFP_KERNEL | GFP_SPI_DMA);
 		if (!dvb_spi->ts_buf) {
 			pr_err("ts buffer allocate failed\n");
 			memset(&dvb_spi->filter_config, 0,
diff --git a/drivers/misc/gehc-achc.c b/drivers/misc/gehc-achc.c
index b8fca4d393c6..42af67fd232d 100644
--- a/drivers/misc/gehc-achc.c
+++ b/drivers/misc/gehc-achc.c
@@ -225,7 +225,7 @@ static int ezport_flash_transfer(struct spi_device *spi, u32 address,
 	if (ret < 0)
 		return ret;
 
-	command = kmalloc(4, GFP_KERNEL | GFP_DMA);
+	command = kmalloc(4, GFP_KERNEL | GFP_SPI_DMA);
 	if (!command)
 		return -ENOMEM;
 
@@ -255,7 +255,7 @@ static int ezport_flash_compare(struct spi_device *spi, u32 address,
 	u8 *buffer;
 	int ret;
 
-	buffer = kmalloc(payload_size + 5, GFP_KERNEL | GFP_DMA);
+	buffer = kmalloc(payload_size + 5, GFP_KERNEL | GFP_SPI_DMA);
 	if (!buffer)
 		return -ENOMEM;
 
diff --git a/drivers/net/wireless/st/cw1200/fwio.c b/drivers/net/wireless/st/cw1200/fwio.c
index 2a03dc533b6a..6cdbb4980b02 100644
--- a/drivers/net/wireless/st/cw1200/fwio.c
+++ b/drivers/net/wireless/st/cw1200/fwio.c
@@ -148,7 +148,7 @@ static int cw1200_load_firmware_cw1200(struct cw1200_common *priv)
 		goto exit;
 	}
 
-	buf = kmalloc(DOWNLOAD_BLOCK_SIZE, GFP_KERNEL | GFP_DMA);
+	buf = kmalloc(DOWNLOAD_BLOCK_SIZE, GFP_KERNEL | GFP_SPI_DMA);
 	if (!buf) {
 		pr_err("Can't allocate firmware load buffer.\n");
 		ret = -ENOMEM;
diff --git a/drivers/net/wireless/st/cw1200/wsm.c b/drivers/net/wireless/st/cw1200/wsm.c
index 4a9e4b5d3547..9a8c6510d1d6 100644
--- a/drivers/net/wireless/st/cw1200/wsm.c
+++ b/drivers/net/wireless/st/cw1200/wsm.c
@@ -1775,7 +1775,7 @@ void wsm_txed(struct cw1200_common *priv, u8 *data)
 void wsm_buf_init(struct wsm_buf *buf)
 {
 	BUG_ON(buf->begin);
-	buf->begin = kmalloc(FWLOAD_BLOCK_SIZE, GFP_KERNEL | GFP_DMA);
+	buf->begin = kmalloc(FWLOAD_BLOCK_SIZE, GFP_KERNEL | GFP_SPI_DMA);
 	buf->end = buf->begin ? &buf->begin[FWLOAD_BLOCK_SIZE] : buf->begin;
 	wsm_buf_reset(buf);
 }
@@ -1804,7 +1804,7 @@ static int wsm_buf_reserve(struct wsm_buf *buf, size_t extra_size)
 
 	size = round_up(size, FWLOAD_BLOCK_SIZE);
 
-	tmp = krealloc(buf->begin, size, GFP_KERNEL | GFP_DMA);
+	tmp = krealloc(buf->begin, size, GFP_KERNEL | GFP_SPI_DMA);
 	if (!tmp) {
 		wsm_buf_deinit(buf);
 		return -ENOMEM;
diff --git a/drivers/net/wireless/ti/wlcore/cmd.c b/drivers/net/wireless/ti/wlcore/cmd.c
index cd8ad0fe59cc..a0063878e47c 100644
--- a/drivers/net/wireless/ti/wlcore/cmd.c
+++ b/drivers/net/wireless/ti/wlcore/cmd.c
@@ -172,7 +172,7 @@ int wlcore_cmd_wait_for_event_or_timeout(struct wl1271 *wl,
 
 	*timeout = false;
 
-	events_vector = kmalloc(sizeof(*events_vector), GFP_KERNEL | GFP_DMA);
+	events_vector = kmalloc(sizeof(*events_vector), GFP_KERNEL);
 	if (!events_vector)
 		return -ENOMEM;
 
diff --git a/drivers/net/wireless/ti/wlcore/main.c b/drivers/net/wireless/ti/wlcore/main.c
index 8fb58a5d911c..02962702b72d 100644
--- a/drivers/net/wireless/ti/wlcore/main.c
+++ b/drivers/net/wireless/ti/wlcore/main.c
@@ -6477,7 +6477,7 @@ struct ieee80211_hw *wlcore_alloc_hw(size_t priv_size, u32 aggr_buf_size,
 	}
 
 	wl->mbox_size = mbox_size;
-	wl->mbox = kmalloc(wl->mbox_size, GFP_KERNEL | GFP_DMA);
+	wl->mbox = kmalloc(wl->mbox_size, GFP_KERNEL | GFP_SPI_DMA);
 	if (!wl->mbox) {
 		ret = -ENOMEM;
 		goto err_fwlog;
diff --git a/include/linux/gfp_types.h b/include/linux/gfp_types.h
index 65db9349f905..6c3d3d7cc6fe 100644
--- a/include/linux/gfp_types.h
+++ b/include/linux/gfp_types.h
@@ -382,6 +382,7 @@ enum {
 #define GFP_NOFS	(__GFP_RECLAIM | __GFP_IO)
 #define GFP_USER	(__GFP_RECLAIM | __GFP_IO | __GFP_FS | __GFP_HARDWALL)
 #define GFP_DMA		__GFP_DMA
+#define GFP_SPI_DMA	__GFP_DMA
 #define GFP_DMA32	__GFP_DMA32
 #define GFP_HIGHUSER	(GFP_USER | __GFP_HIGHMEM)
 #define GFP_HIGHUSER_MOVABLE	(GFP_HIGHUSER | __GFP_MOVABLE | __GFP_SKIP_KASAN)
diff --git a/include/sound/cs35l56.h b/include/sound/cs35l56.h
index 5d653a3491d0..415497307c45 100644
--- a/include/sound/cs35l56.h
+++ b/include/sound/cs35l56.h
@@ -295,7 +295,7 @@ static inline int cs35l56_init_config_for_spi(struct cs35l56_base *cs35l56,
 {
 	cs35l56->spi_payload_buf = devm_kzalloc(&spi->dev,
 						sizeof(*cs35l56->spi_payload_buf),
-						GFP_KERNEL | GFP_DMA);
+						GFP_KERNEL | GFP_SPI_DMA);
 	if (!cs35l56->spi_payload_buf)
 		return -ENOMEM;
 
diff --git a/sound/soc/codecs/arizona.c b/sound/soc/codecs/arizona.c
index 74b0968f425a..c679d278c53e 100644
--- a/sound/soc/codecs/arizona.c
+++ b/sound/soc/codecs/arizona.c
@@ -2734,7 +2734,7 @@ int arizona_eq_coeff_put(struct snd_kcontrol *kcontrol,
 
 	len = params->num_regs * regmap_get_val_bytes(arizona->regmap);
 
-	data = kmemdup(ucontrol->value.bytes.data, len, GFP_KERNEL | GFP_DMA);
+	data = kmemdup(ucontrol->value.bytes.data, len, GFP_KERNEL | GFP_SPI_DMA);
 	if (!data)
 		return -ENOMEM;
 
diff --git a/sound/soc/codecs/madera.c b/sound/soc/codecs/madera.c
index bc3470cf2c54..c75f6a617c73 100644
--- a/sound/soc/codecs/madera.c
+++ b/sound/soc/codecs/madera.c
@@ -4754,7 +4754,7 @@ int madera_eq_coeff_put(struct snd_kcontrol *kcontrol,
 
 	len = params->num_regs * regmap_get_val_bytes(madera->regmap);
 
-	data = kmemdup(ucontrol->value.bytes.data, len, GFP_KERNEL | GFP_DMA);
+	data = kmemdup(ucontrol->value.bytes.data, len, GFP_KERNEL | GFP_SPI_DMA);
 	if (!data)
 		return -ENOMEM;
 
diff --git a/sound/soc/codecs/nau8810.c b/sound/soc/codecs/nau8810.c
index 6f432b992941..2b66c50bbf1b 100644
--- a/sound/soc/codecs/nau8810.c
+++ b/sound/soc/codecs/nau8810.c
@@ -205,7 +205,7 @@ static int nau8810_eq_put(struct snd_kcontrol *kcontrol,
 	__be16 *tmp;
 
 	data = kmemdup(ucontrol->value.bytes.data,
-		params->max, GFP_KERNEL | GFP_DMA);
+		params->max, GFP_KERNEL | GFP_SPI_DMA);
 	if (!data)
 		return -ENOMEM;
 
diff --git a/sound/soc/codecs/nau8821.c b/sound/soc/codecs/nau8821.c
index edb95f869a4a..7cca9dac7e5f 100644
--- a/sound/soc/codecs/nau8821.c
+++ b/sound/soc/codecs/nau8821.c
@@ -303,7 +303,7 @@ static int nau8821_biq_coeff_put(struct snd_kcontrol *kcontrol,
 		return -EINVAL;
 
 	data = kmemdup(ucontrol->value.bytes.data,
-		params->max, GFP_KERNEL | GFP_DMA);
+		params->max, GFP_KERNEL | GFP_SPI_DMA);
 	if (!data)
 		return -ENOMEM;
 
diff --git a/sound/soc/codecs/nau8822.c b/sound/soc/codecs/nau8822.c
index 15d6f8d01f78..016f537ebb30 100644
--- a/sound/soc/codecs/nau8822.c
+++ b/sound/soc/codecs/nau8822.c
@@ -221,7 +221,7 @@ static int nau8822_eq_put(struct snd_kcontrol *kcontrol,
 	__be16 *tmp;
 
 	data = kmemdup(ucontrol->value.bytes.data,
-		params->max, GFP_KERNEL | GFP_DMA);
+		params->max, GFP_KERNEL | GFP_SPI_DMA);
 	if (!data)
 		return -ENOMEM;
 
diff --git a/sound/soc/codecs/nau8825.c b/sound/soc/codecs/nau8825.c
index 25b8b19e27ec..43a73aabf891 100644
--- a/sound/soc/codecs/nau8825.c
+++ b/sound/soc/codecs/nau8825.c
@@ -1017,7 +1017,7 @@ static int nau8825_biq_coeff_put(struct snd_kcontrol *kcontrol,
 		return -EINVAL;
 
 	data = kmemdup(ucontrol->value.bytes.data,
-		params->max, GFP_KERNEL | GFP_DMA);
+		params->max, GFP_KERNEL | GFP_SPI_DMA);
 	if (!data)
 		return -ENOMEM;
 
diff --git a/sound/soc/codecs/tas571x.c b/sound/soc/codecs/tas571x.c
index 6c6e7ae07d80..a0f75b089aa4 100644
--- a/sound/soc/codecs/tas571x.c
+++ b/sound/soc/codecs/tas571x.c
@@ -150,7 +150,7 @@ static int tas571x_reg_write_multiword(struct i2c_client *client,
 	int ret;
 	size_t send_size = 1 + len * sizeof(uint32_t);
 
-	buf = kzalloc(send_size, GFP_KERNEL | GFP_DMA);
+	buf = kzalloc(send_size, GFP_KERNEL | GFP_SPI_DMA);
 	if (!buf)
 		return -ENOMEM;
 	buf[0] = reg;
@@ -183,7 +183,7 @@ static int tas571x_reg_read_multiword(struct i2c_client *client,
 	unsigned int recv_size = len * sizeof(uint32_t);
 	int ret;
 
-	recv_buf = kzalloc(recv_size, GFP_KERNEL | GFP_DMA);
+	recv_buf = kzalloc(recv_size, GFP_KERNEL | GFP_DMA); // XXXX
 	if (!recv_buf)
 		return -ENOMEM;
 
diff --git a/sound/soc/codecs/wm0010.c b/sound/soc/codecs/wm0010.c
index 8d1a575532ff..d1ef988aa84e 100644
--- a/sound/soc/codecs/wm0010.c
+++ b/sound/soc/codecs/wm0010.c
@@ -405,14 +405,14 @@ static int wm0010_firmware_load(const char *name, struct snd_soc_component *comp
 		xfer->component = component;
 		list_add_tail(&xfer->list, &xfer_list);
 
-		out = kzalloc(len, GFP_KERNEL | GFP_DMA);
+		out = kzalloc(len, GFP_KERNEL | GFP_SPI_DMA);
 		if (!out) {
 			ret = -ENOMEM;
 			goto abort1;
 		}
 		xfer->t.rx_buf = out;
 
-		img = kzalloc(len, GFP_KERNEL | GFP_DMA);
+		img = kzalloc(len, GFP_KERNEL | GFP_SPI_DMA);
 		if (!img) {
 			ret = -ENOMEM;
 			goto abort1;
@@ -504,13 +504,13 @@ static int wm0010_stage2_load(struct snd_soc_component *component)
 	dev_dbg(component->dev, "Downloading %zu byte stage 2 loader\n", fw->size);
 
 	/* Copy to local buffer first as vmalloc causes problems for dma */
-	img = kmemdup(&fw->data[0], fw->size, GFP_KERNEL | GFP_DMA);
+	img = kmemdup(&fw->data[0], fw->size, GFP_KERNEL | GFP_SPI_DMA);
 	if (!img) {
 		ret = -ENOMEM;
 		goto abort2;
 	}
 
-	out = kzalloc(fw->size, GFP_KERNEL | GFP_DMA);
+	out = kzalloc(fw->size, GFP_KERNEL | GFP_SPI_DMA);
 	if (!out) {
 		ret = -ENOMEM;
 		goto abort1;
@@ -638,11 +638,11 @@ static int wm0010_boot(struct snd_soc_component *component)
 
 		ret = -ENOMEM;
 		len = pll_rec.length + 8;
-		out = kzalloc(len, GFP_KERNEL | GFP_DMA);
+		out = kzalloc(len, GFP_KERNEL | GFP_SPI_DMA);
 		if (!out)
 			goto abort;
 
-		img_swap = kzalloc(len, GFP_KERNEL | GFP_DMA);
+		img_swap = kzalloc(len, GFP_KERNEL | GFP_SPI_DMA);
 		if (!img_swap)
 			goto abort_out;
 
diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 91c8697c29c3..7e8b44b911c0 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -1373,7 +1373,7 @@ int wm_adsp_compr_set_params(struct snd_soc_component *component,
 		  compr->size.fragment_size, compr->size.fragments);
 
 	size = wm_adsp_compr_frag_words(compr) * sizeof(*compr->raw_buf);
-	compr->raw_buf = kmalloc(size, GFP_DMA | GFP_KERNEL);
+	compr->raw_buf = kmalloc(size, GFP_SPI_DMA | GFP_KERNEL);
 	if (!compr->raw_buf)
 		return -ENOMEM;
 
diff --git a/sound/soc/soc-ops.c b/sound/soc/soc-ops.c
index cd5f927bcd4e..231e80ca0386 100644
--- a/sound/soc/soc-ops.c
+++ b/sound/soc/soc-ops.c
@@ -749,7 +749,7 @@ int snd_soc_bytes_put(struct snd_kcontrol *kcontrol,
 	len = params->num_regs * component->val_bytes;
 
 	void *data __free(kfree) = kmemdup(ucontrol->value.bytes.data, len,
-					   GFP_KERNEL | GFP_DMA);
+					   GFP_KERNEL | GFP_SPI_DMA);
 	if (!data)
 		return -ENOMEM;
 

