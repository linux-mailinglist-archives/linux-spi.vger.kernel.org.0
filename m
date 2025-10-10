Return-Path: <linux-spi+bounces-10530-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 62934BCE1C5
	for <lists+linux-spi@lfdr.de>; Fri, 10 Oct 2025 19:39:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 530554EAF98
	for <lists+linux-spi@lfdr.de>; Fri, 10 Oct 2025 17:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 110BD223DC1;
	Fri, 10 Oct 2025 17:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="jpLHSzkj"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D88322157E
	for <linux-spi@vger.kernel.org>; Fri, 10 Oct 2025 17:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760117972; cv=none; b=IMwYEbavMVkCdwLx0lscvUwBdAsphbIQp0MnNx4rNfF7iEyn1Pyk8aS6YWVB6i9bu4SvRMoUXnrqx3bpVpkTmfaIW+9ir6bQy6NbyY1kaxi3SSXjTedrZ5FKbGg0vFXYDIs5XwzwgIY7pDXUq1ZiAByKrvsBjnDFCUYx+WIqkjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760117972; c=relaxed/simple;
	bh=p8y/s+CYhyKDayoBztOHI0AHLWMRrYFOjG75hEUhgYk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dZwUpmEG6r880MYxIY1UOJ34IbPVVXdJIVdMkbl2vibmbMJP0q++UMSF1rwEP8Z2Nbo3tdwmCa8sh0Vg64P/vtiuR0N6uCFuJpxRCPugaL5/TABHEzdC0ArU7wNU1j2HmNiKGCgbZpG+aezbPinltZq1z5bWVpj2ONU03YrN+Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=jpLHSzkj; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7a7d79839b2so1897105a34.3
        for <linux-spi@vger.kernel.org>; Fri, 10 Oct 2025 10:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1760117968; x=1760722768; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PZ+Dy49i07NMHWC9th7IGBEaPJ8wyTfsNg8yJ9Fy9+c=;
        b=jpLHSzkjzBTfhvqzjF+1UoFXwfHroKWEBjQmLedwpn/L1F4K1yErjcpEDYwELsh9dO
         Vg5j0/p3qDmiiiT/HpgdHR9XHrn3ppPhB+rIFIs+yL82nhMbPcceU81iMvcTt4S4Ix/a
         dDzczYVBhGcY/p4E2AJ1NLMV1yX2g4bJh65z4v0JQHfGEbFj8w99EnsYgByCMQlCzX8k
         ZO/Biz0z+iked0T7lpsw8wIkzUmyxqSM/T6OqkSr2O9bU+clsKHLfR0dabz0uM7goFU1
         QXlCYmjeo42cB9/wHrOkSlvsXzIHXx6aBUovAFRwIiq07bXv4rf+Oip4+nCue/iFWz9i
         VAQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760117968; x=1760722768;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PZ+Dy49i07NMHWC9th7IGBEaPJ8wyTfsNg8yJ9Fy9+c=;
        b=JMkYiKQT6o11fhpHIhzXQghGOeDxnnZn5suBYhAp9FPMmggWKKKDpXhoiYbUl0adD5
         MTIHx/8eqP3UXWnWFMZFjSz287Us5drCN88WlPjIRVZVZMWGqp4kuvYaLJjiOiXp9HkR
         0TIuF4mp7GRpjQEY0WMsM/HGGGVd37SU2V3bbxAcNyGew3NOvGfAhyaJ8jCiaHocY7l8
         w2WS2gOGTZaJgZu5g6wltDVj4K0OP4swsi+w9GJLpgiI0eS4BhVF9VdHYmtO0Aa65XT0
         LjvOHU4wZ19iwS5JUhy3LOnjFi0uRW6iBCXNh0DcC8UAbnUMfxv34S2tJPceE+NQPsDZ
         UfqA==
X-Forwarded-Encrypted: i=1; AJvYcCUcqsRQkwZ/u3wwYRJgWbIETbvU40BtMFcYYzcVLYYHaNpBtI1MFgBLbvDZpnzCwmRNwUmY8qFzzJs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEVkXaGou9gpLGR0ML2wc91njIssdtfEVES8w+V3tO2NfUnSM5
	1qieWdOWvhcoQlVKPe6/G4SlPWAsEakkf0QIGjTMZU7ZEjlTkqREd72EJbT+Ux34lAQ=
X-Gm-Gg: ASbGnct3PY/3qaqblyPVbncQDCBJUUgrGW5vqHZ9b3bVizMR9X5hj+TOvpzGodf5AWS
	rcIEx6jmp0ttiVHRl2YkrhHvxQhs+Hd0woruYVtQeuClBOilcL9oflJK/JiEsdJEVH1AVj8tceD
	hnZ60S7Rm1pPWqNYY8pYkLOaOcwjEyzH8hA3+7GXuODjy1pQUZMeix+Z8YQ8RLAJWb7yBsks3tE
	sUHkDfsbmnJmcXb7IicssC59I4cXqgPnvfGh3w+OvQtv6vGfnQ4XFc13/ZFbboMgf3kre888G8z
	OK0FUCii9T5ljOtNAGYTJh0LdHML8m6z/b7tdt6Eu46SPkfyUh+ah9OtqIJrqQh/lpe7xJhn67G
	ydv8jbbawnknPT+cv6Vb3PIxdA50uF7olWCwo0Srb2T4fLzAP2ZQ9ONN4G/kMJUPpMXVLbZ0vUh
	Jz1iQCJxUorXv03pA=
X-Google-Smtp-Source: AGHT+IEYhPYvlDBLZaZqlLGB+iUT5R4ASjXBM6uBeyLBN/sayw6DH2MjRiDQ+SBu7/siJhgOZPrD1g==
X-Received: by 2002:a05:6808:2223:b0:43f:55f2:4c44 with SMTP id 5614622812f47-4417b2d22c4mr5138879b6e.3.1760117968269;
        Fri, 10 Oct 2025 10:39:28 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:6d3b:e3bd:4210:32e2? ([2600:8803:e7e4:500:6d3b:e3bd:4210:32e2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7c0f915efddsm1009636a34.34.2025.10.10.10.39.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Oct 2025 10:39:27 -0700 (PDT)
Message-ID: <56f63486-20e7-4c9b-8a39-da904b4600ad@baylibre.com>
Date: Fri, 10 Oct 2025 12:39:25 -0500
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/8] iio: adc: ad4030: Add SPI offload support
To: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-pwm@vger.kernel.org, linux-spi@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: jic23@kernel.org, ukleinek@kernel.org, michael.hennerich@analog.com,
 nuno.sa@analog.com, eblanc@baylibre.com, andy@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, corbet@lwn.net,
 marcelo.schmitt1@gmail.com, Trevor Gamblin <tgamblin@baylibre.com>,
 Axel Haslam <ahaslam@baylibre.com>
References: <cover.1759929814.git.marcelo.schmitt@analog.com>
 <2bde211f1bc730ee147c9540b88339a93b2983e6.1759929814.git.marcelo.schmitt@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <2bde211f1bc730ee147c9540b88339a93b2983e6.1759929814.git.marcelo.schmitt@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/8/25 8:51 AM, Marcelo Schmitt wrote:

...

> +static int ad4030_update_conversion_rate(struct ad4030_state *st,
> +					 unsigned int freq, unsigned int avg_log2)

Always nice to have the units, e.g. freq_hz.

> +{
> +	struct spi_offload_trigger_config *config = &st->offload_trigger_config;
> +	struct pwm_waveform cnv_wf = { };
> +	u64 target = AD4030_TCNVH_NS;
> +	u64 offload_period_ns;
> +	u64 offload_offset_ns;
> +	int ret;
> +
> +	/*
> +	 * When averaging/oversampling over N samples, we fire the offload
> +	 * trigger once at every N pulses of the CNV signal. Conversely, the CNV
> +	 * signal needs to be N times faster than the offload trigger. Take that
> +	 * into account to correctly re-evaluate both the PWM waveform connected
> +	 * to CNV and the SPI offload trigger.
> +	 */
> +	freq <<= avg_log2;

nit: modifying function arguments throws me off when reading the code. Would prefer
an additional local variable for this, e.g. cnv_rate_hz = freq << avg_log2.

> +
> +	cnv_wf.period_length_ns = DIV_ROUND_CLOSEST(NSEC_PER_SEC, freq);
> +	/*
> +	 * The datasheet lists a minimum time of 9.8 ns, but no maximum. If the
> +	 * rounded PWM's value is less than 10, increase the target value by 10
> +	 * and attempt to round the waveform again, until the value is at least
> +	 * 10 ns. Use a separate variable to represent the target in case the
> +	 * rounding is severe enough to keep putting the first few results under
> +	 * the minimum 10ns condition checked by the while loop.
> +	 */
> +	do {
> +		cnv_wf.duty_length_ns = target;
> +		ret = pwm_round_waveform_might_sleep(st->cnv_trigger, &cnv_wf);
> +		if (ret)
> +			return ret;
> +		target += AD4030_TCNVH_NS;
> +	} while (cnv_wf.duty_length_ns < AD4030_TCNVH_NS);
> +
> +	if (!in_range(cnv_wf.period_length_ns, AD4030_TCYC_NS, INT_MAX))
> +		return -EINVAL;
> +
> +	offload_period_ns = cnv_wf.period_length_ns;
> +	/*
> +	 * Make the offload trigger period be N times longer than the CNV PWM
> +	 * period when averaging over N samples.
> +	 */
> +	offload_period_ns <<= avg_log2;

Then this could be:

	offload_period_ns = DIV_ROUND_CLOSEST(NSEC_PER_SEC, freq);

Which might avoid some rounding issues.

period_length_ns can have up to 0.5 ns differnce from the exact value, so when
multiplying that by a large oversampling rate (up to 64k), that rounding error
would really add up.

> +
> +	config->periodic.frequency_hz = DIV_ROUND_UP_ULL(NSEC_PER_SEC,
> +							 offload_period_ns);
> +
> +	/*
> +	 * The hardware does the capture on zone 2 (when SPI trigger PWM
> +	 * is used). This means that the SPI trigger signal should happen at
> +	 * tsync + tquiet_con_delay being tsync the conversion signal period
> +	 * and tquiet_con_delay 9.8ns. Hence set the PWM phase accordingly.
> +	 *
> +	 * The PWM waveform API only supports nanosecond resolution right now,
> +	 * so round this setting to the closest available value.
> +	 */
> +	offload_offset_ns = AD4030_TQUIET_CNV_DELAY_NS;
> +	do {
> +		config->periodic.offset_ns = offload_offset_ns;
> +		ret = spi_offload_trigger_validate(st->offload_trigger, config);
> +		if (ret)
> +			return ret;
> +		offload_offset_ns += AD4030_TQUIET_CNV_DELAY_NS;
> +	} while (config->periodic.offset_ns < AD4030_TQUIET_CNV_DELAY_NS);
> +
> +	st->cnv_wf = cnv_wf;
> +
> +	return 0;
> +}

...

> +static int ad4030_set_avg_frame_len(struct iio_dev *dev, unsigned long mask, int avg_val)
> +{
> +	struct ad4030_state *st = iio_priv(dev);
> +	unsigned int avg_log2 = ilog2(avg_val);
> +	unsigned int last_avg_idx = ARRAY_SIZE(ad4030_average_modes) - 1;
> +	int freq;
> +	int ret;
> +
> +	if (avg_val < 0 || avg_val > ad4030_average_modes[last_avg_idx])
> +		return -EINVAL;
> +
> +	ret = ad4030_set_mode(st, mask, avg_log2);

I still think setting the mode here is wrong for the reasons given in a previous review.
There is no "correct" mode until we have a request to read a sample.

And if we drop this, then we can return ad4030_set_avg_frame_len() to it's original
location and reduce the diff.

> +	if (ret)
> +		return ret;
> +
> +	if (st->offload_trigger) {
> +		/*
> +		 * The sample averaging and sampling frequency configurations
> +		 * are mutually dependent one from another. That's because the
> +		 * effective data sample rate is fCNV / 2^N, where N is the
> +		 * number of samples being averaged.
> +		 *
> +		 * When SPI offload is supported and we have control over the
> +		 * sample rate, the conversion start signal (CNV) and the SPI
> +		 * offload trigger frequencies must be re-evaluated so data is
> +		 * fetched only after 'avg_val' conversions.
> +		 */
> +		ad4030_get_sampling_freq(st, &freq);
> +		ret = ad4030_update_conversion_rate(st, freq, avg_log2);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	ret = regmap_write(st->regmap, AD4030_REG_AVG,
> +			   AD4030_REG_AVG_MASK_AVG_SYNC |
> +			   FIELD_PREP(AD4030_REG_AVG_MASK_AVG_VAL, avg_log2));
> +	if (ret)
> +		return ret;
> +
> +	st->avg_log2 = avg_log2;
> +	return 0;
> +}
> +

...

> @@ -869,7 +1035,11 @@ static int ad4030_get_current_scan_type(const struct iio_dev *indio_dev,
>  static int ad4030_update_scan_mode(struct iio_dev *indio_dev,
>  				   const unsigned long *scan_mask)
>  {
> -	return ad4030_set_mode(indio_dev, *scan_mask);
> +	struct ad4030_state *st = iio_priv(indio_dev);
> +

> +	//return ad4030_set_mode(st, *scan_mask, st->avg_log2);
> +	//return ad4030_set_mode(iio_priv(indio_dev), &scan_mask, st->avg_log2);

Oops. :-)

> +	return ad4030_set_mode(iio_priv(indio_dev), *scan_mask, st->avg_log2);
>  }
>  
>  static const struct iio_info ad4030_iio_info = {
> @@ -898,6 +1068,108 @@ static const struct iio_buffer_setup_ops ad4030_buffer_setup_ops = {
>  	.validate_scan_mask = ad4030_validate_scan_mask,
>  };
>  
> +static void ad4030_prepare_offload_msg(struct iio_dev *indio_dev)
> +{
> +	struct ad4030_state *st = iio_priv(indio_dev);
> +	u8 offload_bpw;
> +
> +	if (st->mode == AD4030_OUT_DATA_MD_30_AVERAGED_DIFF) {
> +		offload_bpw = 32;
> +	} else {
> +		offload_bpw = st->chip->precision_bits;
> +		offload_bpw += (st->mode == AD4030_OUT_DATA_MD_24_DIFF_8_COM ||
> +				st->mode == AD4030_OUT_DATA_MD_16_DIFF_8_COM) ? 8 : 0;

The 8-bit common-mode voltage value needs to be in a separate SPI transfer
so that is gets placed in a separate word in the DMA buffer. Otherwise userspace
won't be able to interpret it correctly.

> +	}
> +
> +	st->offload_xfer.bits_per_word = offload_bpw;
> +	st->offload_xfer.len = spi_bpw_to_bytes(offload_bpw);
> +	st->offload_xfer.offload_flags = SPI_OFFLOAD_XFER_RX_STREAM;
> +	spi_message_init_with_transfers(&st->offload_msg, &st->offload_xfer, 1);
> +}
> +
> +static int ad4030_offload_buffer_postenable(struct iio_dev *indio_dev)
> +{
> +	struct ad4030_state *st = iio_priv(indio_dev);
> +	unsigned int reg_modes;
> +	int ret, ret2;
> +
> +	/*
> +	 * When data from 2 analog input channels is output through a single
> +	 * bus line (interleaved mode (LANE_MD == 0b11)) and gets pushed through
> +	 * DMA, extra hardware is required to do the de-interleaving. While we
> +	 * don't support such hardware configurations, disallow interleaved mode
> +	 * when using SPI offload.
> +	 */
> +	ret = regmap_read(st->regmap, AD4030_REG_MODES, &reg_modes);
> +	if (ret)
> +		return ret;
> +
> +	if (st->chip->num_voltage_inputs > 1 &&
> +	    FIELD_GET(AD4030_REG_MODES_MASK_LANE_MODE, reg_modes) == AD4030_LANE_MD_INTERLEAVED)
> +		return -EINVAL;
> +
> +	ret = regmap_write(st->regmap, AD4030_REG_EXIT_CFG_MODE, BIT(0));

There is already AD4030_REG_EXIT_CFG_MODE_EXIT_MSK for BIT(0).

Also there is ad4030_exit_config_mode() that could be called instead. Not sure
why we have that though since there aren't any comments to explain it.

> +	if (ret)
> +		return ret;
> +
> +	ad4030_prepare_offload_msg(indio_dev);
> +	st->offload_msg.offload = st->offload;
> +	ret = spi_optimize_message(st->spi, &st->offload_msg);
> +	if (ret)
> +		goto out_reset_mode;
> +
> +	ret = pwm_set_waveform_might_sleep(st->cnv_trigger, &st->cnv_wf, false);
> +	if (ret)
> +		goto out_unoptimize;
> +
> +	ret = spi_offload_trigger_enable(st->offload, st->offload_trigger,
> +					 &st->offload_trigger_config);
> +	if (ret)
> +		goto out_pwm_disable;
> +
> +	return 0;
> +
> +out_pwm_disable:
> +	pwm_disable(st->cnv_trigger);
> +out_unoptimize:
> +	spi_unoptimize_message(&st->offload_msg);
> +out_reset_mode:
> +	/* reenter register configuration mode */
> +	ret2 = ad4030_enter_config_mode(st);
> +	if (ret2)
> +		dev_err(&st->spi->dev,
> +			"couldn't reenter register configuration mode: %d\n",
> +			ret2);
> +
> +	return ret;
> +}
> +

...

>  static const struct ad4030_chip_info ad4030_24_chip_info = {
>  	.name = "ad4030-24",
>  	.available_masks = ad4030_channel_masks,
> @@ -1125,10 +1511,15 @@ static const struct ad4030_chip_info ad4030_24_chip_info = {
>  		AD4030_CHAN_CMO(1, 0),
>  		IIO_CHAN_SOFT_TIMESTAMP(2),
>  	},
> +	.offload_channels = {
> +		AD4030_OFFLOAD_CHAN_DIFF(0, ad4030_24_offload_scan_types),
> +		AD4030_CHAN_CMO(1, 0),

We will need a new AD4030_OFFLOAD_CHAN_CMO() that has storagebits = 32.

Also applies to similar items below.

> +	},
>  	.grade = AD4030_REG_CHIP_GRADE_AD4030_24_GRADE,
>  	.precision_bits = 24,
>  	.num_voltage_inputs = 1,
>  	.tcyc_ns = AD4030_TCYC_ADJUSTED_NS,
> +	.max_sample_rate_hz = 2 * HZ_PER_MHZ,
>  };
>  
>  static const struct ad4030_chip_info ad4630_16_chip_info = {
> @@ -1141,10 +1532,17 @@ static const struct ad4030_chip_info ad4630_16_chip_info = {
>  		AD4030_CHAN_CMO(3, 1),
>  		IIO_CHAN_SOFT_TIMESTAMP(4),
>  	},
> +	.offload_channels = {
> +		AD4030_OFFLOAD_CHAN_DIFF(0, ad4030_16_offload_scan_types),
> +		AD4030_OFFLOAD_CHAN_DIFF(1, ad4030_16_offload_scan_types),
> +		AD4030_CHAN_CMO(2, 0),
> +		AD4030_CHAN_CMO(3, 1),
> +	},
>  	.grade = AD4030_REG_CHIP_GRADE_AD4630_16_GRADE,
>  	.precision_bits = 16,
>  	.num_voltage_inputs = 2,
>  	.tcyc_ns = AD4030_TCYC_ADJUSTED_NS,
> +	.max_sample_rate_hz = 2 * HZ_PER_MHZ,
>  };
>  
>  static const struct ad4030_chip_info ad4630_24_chip_info = {
> @@ -1157,10 +1555,17 @@ static const struct ad4030_chip_info ad4630_24_chip_info = {
>  		AD4030_CHAN_CMO(3, 1),
>  		IIO_CHAN_SOFT_TIMESTAMP(4),
>  	},
> +	.offload_channels = {
> +		AD4030_OFFLOAD_CHAN_DIFF(0, ad4030_24_offload_scan_types),
> +		AD4030_OFFLOAD_CHAN_DIFF(1, ad4030_24_offload_scan_types),
> +		AD4030_CHAN_CMO(2, 0),
> +		AD4030_CHAN_CMO(3, 1),
> +	},
>  	.grade = AD4030_REG_CHIP_GRADE_AD4630_24_GRADE,
>  	.precision_bits = 24,
>  	.num_voltage_inputs = 2,
>  	.tcyc_ns = AD4030_TCYC_ADJUSTED_NS,
> +	.max_sample_rate_hz = 2 * HZ_PER_MHZ,
>  };
>  
>  static const struct ad4030_chip_info ad4632_16_chip_info = {
> @@ -1173,10 +1578,17 @@ static const struct ad4030_chip_info ad4632_16_chip_info = {
>  		AD4030_CHAN_CMO(3, 1),
>  		IIO_CHAN_SOFT_TIMESTAMP(4),
>  	},
> +	.offload_channels = {
> +		AD4030_OFFLOAD_CHAN_DIFF(0, ad4030_16_offload_scan_types),
> +		AD4030_OFFLOAD_CHAN_DIFF(1, ad4030_16_offload_scan_types),
> +		AD4030_CHAN_CMO(2, 0),
> +		AD4030_CHAN_CMO(3, 1),
> +	},
>  	.grade = AD4030_REG_CHIP_GRADE_AD4632_16_GRADE,
>  	.precision_bits = 16,
>  	.num_voltage_inputs = 2,
>  	.tcyc_ns = AD4632_TCYC_ADJUSTED_NS,
> +	.max_sample_rate_hz = 500 * HZ_PER_KHZ,
>  };
>  
>  static const struct ad4030_chip_info ad4632_24_chip_info = {
> @@ -1189,10 +1601,17 @@ static const struct ad4030_chip_info ad4632_24_chip_info = {
>  		AD4030_CHAN_CMO(3, 1),
>  		IIO_CHAN_SOFT_TIMESTAMP(4),
>  	},
> +	.offload_channels = {
> +		AD4030_OFFLOAD_CHAN_DIFF(0, ad4030_24_offload_scan_types),
> +		AD4030_OFFLOAD_CHAN_DIFF(1, ad4030_24_offload_scan_types),
> +		AD4030_CHAN_CMO(2, 0),
> +		AD4030_CHAN_CMO(3, 1),
> +	},
>  	.grade = AD4030_REG_CHIP_GRADE_AD4632_24_GRADE,
>  	.precision_bits = 24,
>  	.num_voltage_inputs = 2,
>  	.tcyc_ns = AD4632_TCYC_ADJUSTED_NS,
> +	.max_sample_rate_hz = 500 * HZ_PER_KHZ,
>  };
>  
>  static const struct spi_device_id ad4030_id_table[] = {
> @@ -1228,3 +1647,4 @@ module_spi_driver(ad4030_driver);
>  MODULE_AUTHOR("Esteban Blanc <eblanc@baylibre.com>");
>  MODULE_DESCRIPTION("Analog Devices AD4630 ADC family driver");
>  MODULE_LICENSE("GPL");
> +MODULE_IMPORT_NS("IIO_DMAENGINE_BUFFER");


