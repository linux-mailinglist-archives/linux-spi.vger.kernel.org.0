Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 854C32A811E
	for <lists+linux-spi@lfdr.de>; Thu,  5 Nov 2020 15:40:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731074AbgKEOkR (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 5 Nov 2020 09:40:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730676AbgKEOkR (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 5 Nov 2020 09:40:17 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E414BC0613CF
        for <linux-spi@vger.kernel.org>; Thu,  5 Nov 2020 06:40:16 -0800 (PST)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1kagQs-0001Pa-Vk; Thu, 05 Nov 2020 15:40:10 +0100
Received: from ore by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ore@pengutronix.de>)
        id 1kagQs-0008JP-DU; Thu, 05 Nov 2020 15:40:10 +0100
Date:   Thu, 5 Nov 2020 15:40:10 +0100
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Mark Brown <broonie@kernel.org>
Cc:     kernel@pengutronix.de, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org, linux-spi@vger.kernel.org,
        David Jander <david@protonic.nl>
Subject: Re: [PATCH v1 2/2] Input: ads7846: convert to one message
Message-ID: <20201105144010.pqrtr4qscrsr5kbq@pengutronix.de>
References: <20201104153528.25362-1-o.rempel@pengutronix.de>
 <20201104153528.25362-3-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201104153528.25362-3-o.rempel@pengutronix.de>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 15:11:31 up 356 days,  5:30, 380 users,  load average: 0.34, 0.17,
 0.10
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello all,

This patch will need some more work. Currently, it is ignoring
ti,settle-delay-usec property, which should be fixed in the next version.

Regards,
Oleksij

On Wed, Nov 04, 2020 at 04:35:28PM +0100, Oleksij Rempel wrote:
> Convert multiple full duplex transfers in to a single transfer.
> 
> Current driver version support two modes:
> - not filtered
> - driver specific debounce filter
> - platform specific debounce filter (do any platform provides such
> filter?)
> 
> Without filter this HW is not really usable, since the physic of
> resistive touchscreen can provide some bounce effects. With filter, we
> have constant amount of retries + debounce retries if some anomaly was
> detected.
> 
> This patch create one SPI transfer with all fields and not optional retires. If
> bounce anomaly was detected, we will make more transfer if needed.
> 
> Without this patch, we will get about 10% CPU load on iMX6S if some thing
> is pressing on the screen (holding finger, etc.)
> 
> With this patch, depending in the amount of retries, the CPU load will
> be 1.5-2% with "ti,debounce-rep = <3>" and 1% or less with
> "ti,debounce-rep = <10>". Depending on the buffer size, different SPI
> controllers use different optimizations. On iMX, the buffer below
> 64 Byte will be transfered in the PIO mode and beyond this threshold,
> it will be transfered in the DMA mode.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  drivers/input/touchscreen/ads7846.c | 310 +++++++++++++---------------
>  1 file changed, 143 insertions(+), 167 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
> index e9a520c9ad69..a68b9e5aa505 100644
> --- a/drivers/input/touchscreen/ads7846.c
> +++ b/drivers/input/touchscreen/ads7846.c
> @@ -64,37 +64,25 @@
>  
>  struct ads7846_buf {
>  	u8 cmd;
> -	/* This union is a temporary hack. The driver does an in-place
> -	 * endianness conversion. This will be cleaned up in the next
> -	 * patch.
> -	 */
> -	union {
> -		__be16 data_be16;
> -		u16 data;
> -	};
> +	__be16 data;
>  } __attribute__((__packed__));
>  
> -
> -struct ts_event {
> -	bool ignore;
> -	struct ads7846_buf x;
> -	struct ads7846_buf y;
> -	struct ads7846_buf z1;
> -	struct ads7846_buf z2;
> -};
> -
>  /*
>   * We allocate this separately to avoid cache line sharing issues when
>   * driver is used with DMA-based SPI controllers (like atmel_spi) on
>   * systems where main memory is not DMA-coherent (most non-x86 boards).
>   */
>  struct ads7846_packet {
> -	struct ts_event tc;
> -	struct ads7846_buf read_x_cmd;
> -	struct ads7846_buf read_y_cmd;
> -	struct ads7846_buf read_z1_cmd;
> -	struct ads7846_buf read_z2_cmd;
> +	unsigned int count;
> +	unsigned int fields;
> +	unsigned int last_field;
> +	struct ads7846_buf *rx;
> +	struct ads7846_buf *tx;
> +
>  	struct ads7846_buf pwrdown_cmd;
> +
> +	bool ignore;
> +	u16 x, y, z1, z2;
>  };
>  
>  struct ads7846 {
> @@ -206,6 +194,13 @@ struct ads7846 {
>  #define	REF_ON	(READ_12BIT_DFR(x, 1, 1))
>  #define	REF_OFF	(READ_12BIT_DFR(y, 0, 0))
>  
> +enum ads7846_cmds {
> +	ADS7846_Y,
> +	ADS7846_X,
> +	ADS7846_Z1,
> +	ADS7846_Z2,
> +};
> +
>  static int get_pendown_state(struct ads7846 *ts)
>  {
>  	if (ts->get_pendown_state)
> @@ -696,26 +691,68 @@ static int ads7846_no_filter(void *ads, int data_idx, int *val)
>  	return ADS7846_FILTER_OK;
>  }
>  
> -static int ads7846_get_value(struct ads7846 *ts, struct spi_message *m)
> +static int ads7846_get_value(struct ads7846_buf *buf)
>  {
>  	int value;
> -	struct spi_transfer *t =
> -		list_entry(m->transfers.prev, struct spi_transfer, transfer_list);
> -	struct ads7846_buf *buf = t->rx_buf;
>  
> -	value = be16_to_cpup(&buf->data_be16);
> +	value = be16_to_cpup(&buf->data);
>  
>  	/* enforce ADC output is 12 bits width */
>  	return (value >> 3) & 0xfff;
>  }
>  
> -static void ads7846_update_value(struct spi_message *m, int val)
> +static void ads7846_set_field_val(struct ads7846 *ts, enum ads7846_cmds filed,
> +				  u16 val)
>  {
> -	struct spi_transfer *t =
> -		list_entry(m->transfers.prev, struct spi_transfer, transfer_list);
> -	struct ads7846_buf *buf = t->rx_buf;
> +	struct ads7846_packet *packet = ts->packet;
> +
> +	switch (filed) {
> +	case ADS7846_Y:
> +		packet->y = val;
> +		break;
> +	case ADS7846_X:
> +		packet->x = val;
> +		break;
> +	case ADS7846_Z1:
> +		packet->z1 = val;
> +		break;
> +	case ADS7846_Z2:
> +		packet->z2 = val;
> +		break;
> +	default:
> +		pr_err("kappuuuut auch!!!\n");
> +	}
> +}
> +
> +static int ads7846_filter_state(struct ads7846 *ts)
> +{
> +	struct ads7846_packet *packet = ts->packet;
> +	int msg_idx = 0;
> +	int action;
> +	int val;
> +	unsigned int a, b;
>  
> -	buf->data = val;
> +	packet->ignore = false;
> +	for (a = packet->last_field; a < packet->fields; a++) {
> +		packet->last_field = a;
> +		for (b = 0; b < packet->count; b++) {
> +			val = ads7846_get_value(&packet->rx[b * packet->fields + a]);
> +
> +			action = ts->filter(ts->filter_data, msg_idx, &val);
> +			if (action == ADS7846_FILTER_REPEAT) {
> +				if (b == packet->count - 1)
> +					return -EAGAIN;
> +			} else if (action == ADS7846_FILTER_OK) {
> +				ads7846_set_field_val(ts, a, val);
> +				break;
> +			} else {
> +				packet->ignore = true;
> +				return 0;
> +			}
> +		}
> +	}
> +
> +	return 0;
>  }
>  
>  static void ads7846_read_state(struct ads7846 *ts)
> @@ -723,52 +760,30 @@ static void ads7846_read_state(struct ads7846 *ts)
>  	struct ads7846_packet *packet = ts->packet;
>  	struct spi_message *m;
>  	int msg_idx = 0;
> -	int val;
> -	int action;
>  	int error;
>  
> -	while (msg_idx < ts->msg_count) {
> +	packet->last_field = 0;
>  
> +	while (msg_idx < ts->msg_count) {
>  		ts->wait_for_sync();
>  
>  		m = &ts->msg[msg_idx];
>  		error = spi_sync(ts->spi, m);
>  		if (error) {
>  			dev_err(&ts->spi->dev, "spi_sync --> %d\n", error);
> -			packet->tc.ignore = true;
> +			packet->ignore = true;
>  			return;
>  		}
>  
> -		/*
> -		 * Last message is power down request, no need to convert
> -		 * or filter the value.
> -		 */
> -		if (msg_idx < ts->msg_count - 1) {
> +		/* last message is power down request */
> +		if (msg_idx == ts->msg_count - 1)
> +			break;
>  
> -			val = ads7846_get_value(ts, m);
> +		error = ads7846_filter_state(ts);
> +		if (error)
> +			continue;
>  
> -			action = ts->filter(ts->filter_data, msg_idx, &val);
> -			switch (action) {
> -			case ADS7846_FILTER_REPEAT:
> -				continue;
> -
> -			case ADS7846_FILTER_IGNORE:
> -				packet->tc.ignore = true;
> -				msg_idx = ts->msg_count - 1;
> -				continue;
> -
> -			case ADS7846_FILTER_OK:
> -				ads7846_update_value(m, val);
> -				packet->tc.ignore = false;
> -				msg_idx++;
> -				break;
> -
> -			default:
> -				BUG();
> -			}
> -		} else {
> -			msg_idx++;
> -		}
> +		msg_idx++;
>  	}
>  }
>  
> @@ -783,14 +798,14 @@ static void ads7846_report_state(struct ads7846 *ts)
>  	 * from on-the-wire format as part of debouncing to get stable
>  	 * readings.
>  	 */
> -	x = packet->tc.x.data;
> -	y = packet->tc.y.data;
> +	x = packet->x;
> +	y = packet->y;
>  	if (ts->model == 7845) {
>  		z1 = 0;
>  		z2 = 0;
>  	} else {
> -		z1 = packet->tc.z1.data;
> -		z2 = packet->tc.z2.data;
> +		z1 = packet->z1;
> +		z2 = packet->z2;
>  	}
>  
>  	/* range filtering */
> @@ -822,9 +837,9 @@ static void ads7846_report_state(struct ads7846 *ts)
>  	 * the maximum. Don't report it to user space, repeat at least
>  	 * once more the measurement
>  	 */
> -	if (packet->tc.ignore || Rt > ts->pressure_max) {
> +	if (packet->ignore || Rt > ts->pressure_max) {
>  		dev_vdbg(&ts->spi->dev, "ignored %d pressure %d\n",
> -			 packet->tc.ignore, Rt);
> +			 packet->ignore, Rt);
>  		return;
>  	}
>  
> @@ -981,17 +996,62 @@ static int ads7846_setup_pendown(struct spi_device *spi,
>  	return 0;
>  }
>  
> +
> +static u8 ads7846_get_cmd(enum ads7846_cmds filed, int vref)
> +{
> +	switch (filed) {
> +	case ADS7846_Y:
> +		return READ_Y(vref);
> +	case ADS7846_X:
> +		return READ_X(vref);
> +
> +	/* 7846 specific commands  */
> +	case ADS7846_Z1:
> +		return READ_Z1(vref);
> +	case ADS7846_Z2:
> +		return READ_Z2(vref);
> +	default:
> +		pr_err("kappuuuut!!!\n");
> +	}
> +
> +	return 0;
> +}
> +
>  /*
>   * Set up the transfers to read touchscreen state; this assumes we
>   * use formula #2 for pressure, not #3.
>   */
> -static void ads7846_setup_spi_msg(struct ads7846 *ts,
> +static int ads7846_setup_spi_msg(struct ads7846 *ts,
>  				  const struct ads7846_platform_data *pdata)
>  {
>  	struct spi_message *m = &ts->msg[0];
>  	struct spi_transfer *x = ts->xfer;
>  	struct ads7846_packet *packet = ts->packet;
>  	int vref = pdata->keep_vref_on;
> +	unsigned int a, b;
> +	size_t size;
> +
> +	if (ts->debounce_max && ts->debounce_rep)
> +		/* ads7846_debounce_filter() is making ts->debounce_rep + 2
> +		 * reads. So we need to get all samples for normal case. */
> +		packet->count = ts->debounce_rep + 2;
> +	else
> +		packet->count = 1;
> +
> +	if (ts->model == 7846)
> +		packet->fields = 4; /* x, y, z1, z2 */
> +	else
> +		packet->fields = 2; /* x, y */
> +
> +	size = sizeof(*packet->tx) * packet->count * packet->fields;
> +
> +	packet->tx = devm_kzalloc(&ts->spi->dev, size, GFP_KERNEL);
> +	if (!packet->tx)
> +		return -ENOMEM;
> +
> +	packet->rx = devm_kzalloc(&ts->spi->dev, size, GFP_KERNEL);
> +	if (!packet->rx)
> +		return -ENOMEM;
>  
>  	if (ts->model == 7873) {
>  		/*
> @@ -1007,110 +1067,24 @@ static void ads7846_setup_spi_msg(struct ads7846 *ts,
>  	spi_message_init(m);
>  	m->context = ts;
>  
> -	packet->read_y_cmd.cmd = READ_Y(vref);
> -	x->tx_buf = &packet->read_y_cmd;
> -	x->rx_buf = &packet->tc.y;
> -	x->len = 3;
> -	spi_message_add_tail(x, m);
> -
> -	/*
> -	 * The first sample after switching drivers can be low quality;
> -	 * optionally discard it, using a second one after the signals
> -	 * have had enough time to stabilize.
> -	 */
> -	if (pdata->settle_delay_usecs) {
> -		x->delay.value = pdata->settle_delay_usecs;
> -		x->delay.unit = SPI_DELAY_UNIT_USECS;
> -		x++;
> -
> -		x->tx_buf = &packet->read_y_cmd;
> -		x->rx_buf = &packet->tc.y;
> -		x->len = 3;
> -		spi_message_add_tail(x, m);
> +	for (a = 0; a < packet->count; a++) {
> +		for (b = 0; b < packet->fields; b++) {
> +			u8 cmd = ads7846_get_cmd(b, vref);
> +			packet->tx[a * packet->fields + b].cmd = cmd;
> +		}
>  	}
>  
> -	ts->msg_count++;
> -	m++;
> -	spi_message_init(m);
> -	m->context = ts;
> -
> -	/* turn y- off, x+ on, then leave in lowpower */
> -	x++;
> -	packet->read_x_cmd.cmd = READ_X(vref);
> -	x->tx_buf = &packet->read_x_cmd;
> -	x->rx_buf = &packet->tc.x;
> -	x->len = 3;
> +	x->tx_buf = packet->tx;
> +	x->rx_buf = packet->rx;
> +	x->len = size;
> +	x->cs_change = 1; /* do not set CS until we do the PWRDOWN */
>  	spi_message_add_tail(x, m);
>  
> -	/* ... maybe discard first sample ... */
> -	if (pdata->settle_delay_usecs) {
> -		x->delay.value = pdata->settle_delay_usecs;
> -		x->delay.unit = SPI_DELAY_UNIT_USECS;
> -
> -		x++;
> -		x->tx_buf = &packet->read_x_cmd;
> -		x->rx_buf = &packet->tc.x;
> -		x->len = 3;
> -		spi_message_add_tail(x, m);
> -	}
> -
> -	/* turn y+ off, x- on; we'll use formula #2 */
> -	if (ts->model == 7846) {
> -		ts->msg_count++;
> -		m++;
> -		spi_message_init(m);
> -		m->context = ts;
> -
> -		x++;
> -		packet->read_z1_cmd.cmd = READ_Z1(vref);
> -		x->tx_buf = &packet->read_z1_cmd;
> -		x->rx_buf = &packet->tc.z1;
> -		x->len = 3;
> -		spi_message_add_tail(x, m);
> -
> -		/* ... maybe discard first sample ... */
> -		if (pdata->settle_delay_usecs) {
> -			x->delay.value = pdata->settle_delay_usecs;
> -			x->delay.unit = SPI_DELAY_UNIT_USECS;
> -
> -			x++;
> -			x->tx_buf = &packet->read_z1_cmd;
> -			x->rx_buf = &packet->tc.z1;
> -			x->len = 3;
> -			spi_message_add_tail(x, m);
> -		}
> -
> -		ts->msg_count++;
> -		m++;
> -		spi_message_init(m);
> -		m->context = ts;
> -
> -		x++;
> -		packet->read_z2_cmd.cmd = READ_Z2(vref);
> -		x->tx_buf = &packet->read_z2_cmd;
> -		x->rx_buf = &packet->tc.z2;
> -		x->len = 3;
> -		spi_message_add_tail(x, m);
> -
> -		/* ... maybe discard first sample ... */
> -		if (pdata->settle_delay_usecs) {
> -			x->delay.value = pdata->settle_delay_usecs;
> -			x->delay.unit = SPI_DELAY_UNIT_USECS;
> -
> -			x++;
> -			x->tx_buf = &packet->read_z2_cmd;
> -			x->rx_buf = &packet->tc.z2;
> -			x->len = 3;
> -			spi_message_add_tail(x, m);
> -		}
> -	}
> -
> -	/* power down */
>  	ts->msg_count++;
>  	m++;
>  	spi_message_init(m);
>  	m->context = ts;
> -
> +	/* power down */
>  	x++;
>  	packet->pwrdown_cmd.cmd = PWRDOWN;
>  	x->tx_buf = &packet->pwrdown_cmd;
> @@ -1118,6 +1092,8 @@ static void ads7846_setup_spi_msg(struct ads7846 *ts,
>  
>  	CS_CHANGE(*x);
>  	spi_message_add_tail(x, m);
> +
> +	return 0;
>  }
>  
>  #ifdef CONFIG_OF
> -- 
> 2.28.0
> 
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
